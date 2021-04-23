# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import (absolute_import, division, print_function)

# You can import any python module as needed.
import os

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.core.loader import CommandLoader


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class icd(Command):
    """
    :icd

    Interactive directory finder
    """
    def execute(self):
        import subprocess
        import os.path
        command="find . -maxdepth 4 -type d -printf '%P\n' 2>/dev/null | fzf"
        res = self.fm.execute_command(command, universal_newlines=True, stdout=subprocess.PIPE)
        stdout, stderr = res.communicate()
        if res.returncode == 0:
            path = os.path.abspath(stdout.rstrip('\n'))
            self.fm.cd(path)


class extracthere(Command):
    """
    :extracthere

    Extract selected archives to sub directory.
    """
    def execute(self):
        selected_files = self.fm.thisdir.get_selection()

        if not selected_files:
            self.fm.notify("Error: no files selected!", bad=True)
            return

        from os.path import exists, join, splitext
        from os import makedirs

        def refresh(_):
            self.fm.reload_cwd()
            output_dir = self.fm.get_directory(out_dir)
            output_dir.load_content()

        for f in selected_files:
            out_dir = os.path.join(self.fm.thisdir.path,
                    os.path.splitext(f.basename)[0])

            if os.path.exists(out_dir):
                self.fm.notify("Error: path '%s' already exists!" % out_dir,
                        bad=True)
                continue

            os.makedirs(out_dir)

            cmd = ['patool', 'extract']
            cmd.extend(['--outdir', out_dir])
            cmd.append(f.path)

            descr = "Extracting '%s' to '%s'" % (f.basename, out_dir)

            obj = CommandLoader(args=cmd, descr=descr, read=True)
            obj.signal_bind('after', refresh)
            self.fm.loader.add(obj)


class extract(Command):
    """
    :extract [--outdir OUTDIR] archive [archive ...]

    Extract archives with 'patool extract'.
    """
    def execute(self):
        import shlex

        if self.rest(1):
            cmd_args = shlex.split(self.rest(1))
        else:
            self.fm.notify("Error: no arguments provided!", bad=True)
            return

        def refresh(_):
            self.fm.reload_cwd()

        cmd = ['patool', 'extract']
        cmd.extend(cmd_args)

        descr = "Extracing archive ..."

        obj = CommandLoader(args=cmd, descr=descr, read=True)
        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        return self._tab_directory_content()


class compress(Command):
    """
    :compress <archive>

    Create an archive from selected files. The format of the archive to create
    is determined by the archive file extension.

    Examples:
    :compress archive.tar.gz
    :compress archive.zip
    """
    def execute(self):
        import shlex

        if self.rest(1):
            cmd_args = shlex.split(self.rest(1))
            archive_path = cmd_args[0]
            # files = cmd_args[1:]
        else:
            self.fm.notify("Syntax: compess <archive>", bad=True)
            return

        if not files:
            self.fm.notify("Error: no files selected!", bad=True)
            return

        def refresh(_):
            self.fm.reload_cwd()

        cmd = ['patool', 'create']
        cmd.append(archive_path)
        cmd.extend([f.relative_path for f in files])

        descr = "Compressing %s" % archive_path

        obj = CommandLoader(args=cmd, descr=descr, read=True)
        obj.signal_bind('after', refresh)
        self.fm.loader.add(obj)

    def tab(self, tabnum):
        """ Complete with current folder name """

        extensions = ['.tar.gz', '.tar.xz', '.tar.bz2', '.zip', '.rar', '.7z']
        return (self.start(1) + self.fm.thisdir.basename + e for e in
                extensions)


class toggle_flat(Command):
    """
    :toggle_flat

    Flattens or unflattens the directory view.
    """

    def execute(self):
        if self.fm.thisdir.flat == 0:
            self.fm.thisdir.unload()
            self.fm.thisdir.flat = -1
            self.fm.thisdir.load_content()
        else:
            self.fm.thisdir.unload()
            self.fm.thisdir.flat = 0
            self.fm.thisdir.load_content()


class move_to_trash(Command):
    """:move_to_trash

    Move to trash the selection or the files passed in arguments (if any).
    The arguments use a shell-like escaping.

    "Selection" is defined as all the "marked files" (by default, you
    can mark files with space or v). If there are no marked files,
    use the "current file" (where the cursor is)

    When attempting to delete non-empty directories or multiple
    marked files, it will require a confirmation.
    """

    allow_abbrev = False
    escape_macros_for_shell = True

    def execute(self):
        import shlex
        from functools import partial

        def is_directory_with_files(path):
            return os.path.isdir(path) and not os.path.islink(path) and len(os.listdir(path)) > 0

        if self.rest(1):
            files = shlex.split(self.rest(1))
            many_files = (len(files) > 1 or is_directory_with_files(files[0]))
        else:
            cwd = self.fm.thisdir
            tfile = self.fm.thisfile
            if not cwd or not tfile:
                self.fm.notify("Error: no file selected for deletion!", bad=True)
                return

            # relative_path used for a user-friendly output in the confirmation.
            files = [f.relative_path for f in self.fm.thistab.get_selection()]
            many_files = (cwd.marked_items or is_directory_with_files(tfile.path))

        confirm = self.fm.settings.confirm_on_delete
        if confirm != 'never' and (confirm != 'multiple' or many_files):
            self.fm.ui.console.ask(
                "Confirm deletion of: %s (y/N)" % ', '.join(files),
                partial(self._question_callback, files),
                ('n', 'N', 'y', 'Y'),
            )
        else:
            # no need for a confirmation, just delete
            self.fm.run(['gio', 'trash'] + [f for f in files])

    def tab(self, tabnum):
        return self._tab_directory_content()

    def _question_callback(self, files, answer):
        if answer == 'y' or answer == 'Y':
            self.fm.run(['gio', 'trash'] + [f for f in files])


class empty_trash(Command):
    """:empty_trash

    Runs `gio trash --empty`
    """

    def execute(self):
        from functools import partial

        self.fm.ui.console.ask(
            "Confirm emptying trash (y/N)",
            partial(self._question_callback),
            ('n', 'N', 'y', 'Y'),
        )

    def _question_callback(self, answer):
        if answer == 'y' or answer == 'Y':
            self.fm.run(['gio', 'trash', '--empty'])
