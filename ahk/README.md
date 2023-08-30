# ahk

A collection of random [AHKv2](https://www.autohotkey.com/v2/) scripts. i use a primary `main_script.ahk` to organize/modularize some other things, but i've left some basic directives commented out in each of the component files. Here's what we've got:

| File | Description |
| --- | --- |
| [Main Script](main_script.ahk) | Holds miscellaneous things and uses the `#Import` directive to gather up the rest. |
| [Box Drawing](box_drawing.ahk) | A small set of unicode characters for drawing boxes; works best in monospaced contexts. |
| [Obsidian Menu](obsidian_menu.ahk) | A context menu that acts as a quick launcher for my [Obsidian](https://www.obsidian.md) vaults, and provides a means of handling some pseuodo-hotstrings. Could be improved with proper OOP by leaps and bounds. |

Comments are provided for a moderate amount of what's in here, and anything that was not my own code has been given at least cursory attribution. If anything seems missing or amiss, please let me know.
