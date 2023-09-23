# Kitten to print the current list of keyboard shortcuts
# based on
# https://github.com/mivok/dotfiles/blob/master/terminal/.config/kitty/keymap.py
#
# Place this in ~/.config/kitty/keymap.py then
# Add "map kitty_mod+/ kitten keymap.py" to your kitty.conf

from kitty import fast_data_types
from kitty.types import Shortcut
from collections import OrderedDict
import re

# List of categories and regular expressions to match actions on
categories = OrderedDict((
    ('Scrolling', r'(^scroll_|show_scrollback|show_last_command_output)'),
    ('Tab Management', r'((^|_)tab(_|$| )|next_layout)'),
    ('Window Management', r'(^|_)windows?(_|$)'),
    ('Kitten', r'^kitten'),
    ('Other Shortcuts', r'.'),
))


def main(args):
    return ''


def flatten_sequence_map(m):
    ans = {}
    for key_spec, rest_map in m.items():
        for r, action in rest_map.items():
            ans[Shortcut((key_spec,) + (r))] = action
    return ans


def handle_result(args, answer, target_window_id, boss):
    opts = fast_data_types.get_options()
    keymap = opts.keymap

    header = ["Kitty keyboard mappings", "=" * 23, ""]
    output_categorized = {}

    shortcuts = {Shortcut((k,)): v for k, v in keymap.items()}
    shortcuts_seq = flatten_sequence_map(opts.sequence_map)
    shortcuts.update(shortcuts_seq)

    for key, action in shortcuts.items():
        for category in categories:
            if re.search(categories[category], action):
                break

        output_categorized.setdefault(category, []).append(
            f'{key.human_repr(opts.kitty_mod)} → {action}')

    output = header.copy()
    for category in categories:
        if category in output_categorized:
            output.extend([category, "=" * len(category), ""])
            output.extend(output_categorized[category])
            output.append("")

    boss.display_scrollback(boss.active_window, "\n".join(output[:-1]),
                            title="Kitty keyboard mappings",
                            report_cursor=False)
