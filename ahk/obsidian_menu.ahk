; enable directives if not including in another script
; #Requires AutoHotkey v2.0+
; #SingleInstance
; #Include "%A_ScripDir%"
; #Include "functions.ahk"

; === big funny Obsidian-related menu thing ===

; Obsidan Quick Access Menu
!#o::ObsiMenu.Show()

; declare menu
ObsiMenu := BetterMenu([
	["&Open Vault", [
		[],
		["1. &Haecceitas", (*) => Run("obsidian://open?vault=Haecceitas")],
		["2. &CSS_Playground", (*) => Run("obsidian://open?vault=CSS_Playground")]
	], ["C:\Users\sailK\Documents\Obsidian\obsi-icon-48.ico"]],
	["Print a &Settings string", [
		[],
		["1. &Editor", [
            ["& ", (*) => PrintSetting("Settings -> Editor -> ")],
            [],
            ["1. &Readable line length", (*) => PrintSetting("Settings -> Editor -> Readable line length -> ")],
            ["2. &Strict line breaks", (*) => PrintSetting("Settings -> Editor -> Strict line breaks -> ")],
            ["3. &Properties in document", (*) => PrintSetting("Settings -> Editor -> Properties in document -> ")],
            ["4. Show line &number", (*) => PrintSetting("Settings -> Editor -> Show line number -> ")],
            ["5. Show &indentation guides", (*) => PrintSetting("Settings -> Editor -> Show indentation guides -> ")]
        ]],
		["2. &Files && Links", [
            ["& ", (*) => PrintSetting("Settings -> Files & Links -> ")],
            [],
            ["1. &Default location for new notes", (*) => PrintSetting("Settings -> Files & Links -> Default location for new notes -> ")],
            ["2. &New link format", (*) => PrintSetting("Settings -> Files & Links -> New link format -> ")],
            ["3. &Use [[Wikilinks]]", (*) => PrintSetting("Settings -> Files & Links -> Use [[Wikilinks]] -> ")],
            ["4. Detect all &file extensions", (*) => PrintSetting("Settings -> Files & Links -> Detect all file extensions -> ")],
            ["5. Default location for new &attachments", (*) => PrintSetting("Settings -> Files & Links -> Default location for new attachments -> ")],
            ["6. &Excluded files", (*) => PrintSetting("Settings -> Files & Links -> Excluded files -> ")]
        ]],
		["3. &Appearance", [
            ["& ", (*) => PrintSetting("Settings -> Appearance -> ")],
            [],
            ["1. Show &inline title", (*) => PrintSetting("Settings -> Appearance -> Show inline title")],
            ["2. Show tab title &bar", (*) => PrintSetting("Settings -> Appearance -> Show tab title bar")],
            ["3. &Native menus", (*) => PrintSetting("Settings -> Appearance -> Native menus")],
            ["4. &Translucent window", (*) => PrintSetting("Settings -> Appearance -> Translucent window")],
            ["5. &Window frame style", (*) => PrintSetting("Settings -> Appearance -> Window frame style")],
            ["6. &CSS Snippets", (*) => PrintSetting("Settings -> Appearance -> CSS Snippets")]
        ]],
		["4. &Hotkeys", (*) => PrintSetting("Settings -> Hotkeys -> ")],
        ["5. A&bout", [
            ["& ", (*) => PrintSetting("Settings -> Hotkeys -> ")],
            [],
            ["1. &Automatic updates", (*) => PrintSetting("Settings -> About -> Automatic updates -> ")]
        ]]
	]],
    ["&Link a resource", [
        ["1. &Markdown Syntax", (*) => SendText("[Markdown syntax](<https://www.markdownguide.org/basic-syntax/>)")],
        ["2. &Format Your Notes", (*) => SendText("[formatting your notes](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>)")],
        ["3. &Learn about links", (*) => SendText("[links](<https://help.obsidian.md/Linking+notes+and+files/Internal+links>)")]
    ]]
])

PrintSetting(string) {
    HotPaste("``" . string . "$|$``")
}

; courtesy of @geekdude on the AHK Discord
; source: https://p.ahkscript.org/?p=d59f26b0
class BetterMenu extends Menu {
	_items := Map()

	__New(structure := []) {
		for entry in structure {
			if entry.Length < 2 {
				this.Add()
				continue
			}
			item := entry[2] is Array ? BetterMenu(entry[2]) : entry[2]
			this.Add(entry[1], item)
			this._items[entry[1]] := item
			if entry.Length >= 3
				this.SetIcon(entry[1], (entry[3] is Array ? entry[3] : [entry[3]])*)
		}
	}

	/**
	 * Gets a submenu by name
	 * @param {String} MenuItemName The text of the menu item
	 * @return {BetterMenu}
	 */
	GetSubmenu(menuItemName) => this._items[menuItemName]
}