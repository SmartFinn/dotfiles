#!/usr/bin/env python3

"""Find files with identical names in multiple directories

Usage:
    find-indentical-filenames.py DIR [DIR ...]

Options:
    -d --max-depth N
        Maximum depth of recursion (default: -1)
    -f --follow
        Follow symbolic links (default: False)
    -l --long
        Long listing format (default: False)
    --hyperlink
        Display paths as hyperlinks (default: False)

@author: SmartFinn (https://github.com/SmartFinn)
@license: MIT
"""

from argparse import ArgumentParser, ArgumentTypeError
from collections.abc import Generator
from datetime import datetime
from pathlib import Path
from typing import TYPE_CHECKING

if TYPE_CHECKING:
    from os import stat_result


class FileStats:
    def __init__(self, path: Path) -> None:
        self.path: Path = path

        try:
            self.stat: stat_result = path.stat()
            self.size: int = self.stat.st_size
            self.ctime: float = self.stat.st_ctime
            self.mtime: float = self.stat.st_mtime
        except (FileNotFoundError, OSError):
            self.size: int = 0
            self.ctime: float = 0
            self.mtime: float = 0

    def __repr__(self) -> str:
        return (
            f"{self.get_human_readable_datetime(self.ctime)}  "
            f"{self.get_human_readable_datetime(self.mtime)} "
            f"{self.get_human_readable_size(self.size):>7} "
        )

    @staticmethod
    def get_human_readable_size(size: int | float) -> str:
        """Get human-readable size"""
        if size > 1024:
            for unit in ["k", "M", "G", "T"]:
                size /= 1024
                if size < 1024:
                    return f"{size:.1f}{unit}"

        return f"{size}"

    @staticmethod
    def get_human_readable_datetime(dt: int | float) -> str:
        """Get human-readable datetime"""
        return datetime.fromtimestamp(dt).strftime("%Y-%m-%d %H:%M:%S")


def walk(
    path: Path, recursive: bool = True, follow_symlinks: bool = False
) -> Generator[Path, Path, None]:
    for item in Path(path).iterdir():
        if item.is_dir() and recursive:
            if item.is_symlink() and not follow_symlinks:
                continue
            yield from walk(item, recursive, follow_symlinks)
            continue

        yield item


def make_hyperlink(path: Path) -> str:
    """Display path as a hyperlink in the terminal"""
    full_path = path if path.is_absolute() else path.absolute()
    return f"\033]8;;file://{full_path}\033\\{path}\033]8;;\033\\"


def directory(path: str) -> Path:
    """Raise error if arg is not a directory"""
    if not Path(path).is_dir():
        raise ArgumentTypeError(f"'{path}' is not a directory.")
    return Path(path)


def get_file_dict(
    directories: list[Path],
    follow_symlinks: bool = False,
    recursive: bool = True,
) -> dict[str, list[Path]]:
    """Get list of files in directory and subdirectories"""
    file_dict: dict[str, list[Path]] = {}

    for directory in directories:
        for file_path in walk(directory, recursive, follow_symlinks):
            file_name = file_path.name
            if file_name in file_dict:
                file_dict[file_name].append(file_path)
            else:
                file_dict[file_name] = [file_path]

    return file_dict


def find_indentical_filenames(
    directories: list[Path],
    recursive: bool = True,
    follow_symlinks: bool = False,
    hyperlinks: bool = False,
    file_stats: bool = False,
) -> None:
    file_dict: dict[str, list[Path]] = get_file_dict(
        directories, recursive=recursive, follow_symlinks=follow_symlinks
    )

    for _, paths in file_dict.items():
        if len(paths) > 1:
            for path in paths:
                if file_stats:
                    print(FileStats(path), end=" ")
                print(make_hyperlink(path) if hyperlinks else path)
            print()


if __name__ == "__main__":
    parser = ArgumentParser(
        description="Find files with identical names in multiple directories"
    )
    parser.add_argument("directories", nargs="+", type=directory)
    parser.add_argument(
        "-n",
        "--no-recursive",
        action="store_true",
        dest="no_recursive",
        default=False,
        help="Disable recursion (default: %(default)s)",
    )
    parser.add_argument(
        "-f",
        "--follow",
        action="store_true",
        dest="follow",
        default=False,
        help="Follow symbolic links (default: %(default)s)",
    )
    parser.add_argument(
        "-l",
        "--long",
        action="store_true",
        dest="long",
        default=False,
        help="Long listing format (default: %(default)s)",
    )
    parser.add_argument(
        "--hyperlink",
        action="store_true",
        dest="hyperlink",
        default=False,
        help="Display paths as hyperlinks (default: %(default)s)",
    )
    args = parser.parse_args()

    find_indentical_filenames(
        args.directories,
        recursive=bool(not args.no_recursive),
        follow_symlinks=args.follow,
        hyperlinks=args.hyperlink,
        file_stats=args.long,
    )
