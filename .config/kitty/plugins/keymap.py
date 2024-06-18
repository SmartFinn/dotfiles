# Kitten to print the current list of keyboard shortcuts
# based on
# https://github.com/mivok/dotfiles/blob/master/terminal/.config/kitty/keymap.py
#
# Place this in ~/.config/kitty/keymap.py then
# Add "map kitty_mod+/ kitten keymap.py" to your kitty.conf

from kittens.tui.handler import result_handler
from kitty import fast_data_types
from kitty.types import Shortcut, mod_to_names
from kitty.boss import Boss
from collections import OrderedDict
import re

# List of categories and regular expressions to match actions on
categories = OrderedDict((
    ('Scrolling', r'(^scroll_|show_scrollback|show_last_command_output)'),
    ('Tab Management', r'((^|_)tab(_|$| )|next_layout)'),
    ('Window Management', r'(^|_)windows?(_|$)'),
    ('Kitten', r'^kitten'),
    ('Launch', r'^launch'),
    ('Other Shortcuts', r'.'),
))


def main(args: list[str]) -> None:
    pass


def flatten_sequence_map(keymap: dict) -> dict:
    ans: dict[Shortcut, str] = {}
    for key_spec, defns in keymap.items():
        for d in defns:
            ans[Shortcut(d.full_key_sequence_to_trigger)] = d.human_repr()
    return ans


@result_handler(no_ui=True)
def handle_result(args: list[str], answer: str, target_window_id: int, boss:
                  Boss):
    opts = fast_data_types.get_options()
    keymap = opts.keyboard_modes[''].keymap

    output_categorized: dict = {}
    shortcuts: dict = flatten_sequence_map(keymap)

    for key, action in shortcuts.items():
        for category in categories:
            if re.search(categories[category], action):
                break

        output_categorized.setdefault(category, []).append(
            f'{key.human_repr(opts.kitty_mod):<20} → {action}')

    output: list[str] = [
        "Kitty keyboard mappings",
        "=======================",
        "",
        "My kitty_mod is {}.".format("+".join(mod_to_names(opts.kitty_mod))),
        "",
    ]
    for category in categories:
        if category not in output_categorized:
            continue
        output.extend([category, "=" * len(category), ""])
        output.extend(output_categorized[category])
        output.append("")

    boss.display_scrollback(boss.active_window, "\n".join(output[:-1]),
                            title="Kitty keyboard mappings",
                            report_cursor=False)
