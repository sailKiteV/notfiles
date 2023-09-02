; enable directives if not including in another script
; #Requires AutoHotkey v2.0+
; #SingleInstance
; #Include "%A_ScripDir%"
; #Include "functions.ahk"

; === Obsidian big pastes ===

; basic Markdown resources
:*T0?:;pmdb:: {
    text := "
    (
    ### Markdown Resources
    - [Obsidian Basic Formatting](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>) | Learn many of the basics of Markdown in Obsidian.
    - [Markdown Guide](<https://www.markdownguide.org/basic-syntax>) | Learn more about how Markdown renders various elements by syntax.
    )"

    HotPaste(text)
}
; full Markdown resources
:*T0?:;pmdf:: {
    text := "
    (
    ### Markdown Resources
    - [Obsidian Basic Formatting](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>) | Learn many of the basics of Markdown in Obsidian.
    - [Markdown Guide](<https://www.markdownguide.org/basic-syntax>) | Learn more about how Markdown renders various elements by syntax.
    - [CommonMark Spec](<https://spec.commonmark.org/current/>) | One of the more detailed specifications for Markdown (as a reference).
    - [GFM Spec](<https://github.github.com/gfm/>) | Specification for GitHub Flavored Markdown; based on CommonMark.
    - [Canadian Government of Northwest Territories, Justice Dept.](<https://www.justice.gov.nt.ca/en/docs/markdown/page/3/>) | Surprisingly concise resource for learning about loose lists, don't ask me why.
    )"

    HotPaste(text)
}

; Obsidian multi-column formatting quick links.
:*T0?:;obsicol:: {
    text := "
    (
    - [Multi-Column Markdown](<https://obsidian.md/plugins?id=multi-column-markdown>)
    - [Obsidian Columns](<https://obsidian.md/plugins?id=obsidian-columns>)
    - [efemkay's modular CSS](<https://github.com/efemkay/obsidian-modular-css-layout>)
    )"

    HotPaste(text)
}

; Obsidian file tree plugin quick links.
:*T0?:;obsitree:: {
    text := "
    (
    - [Custom Sort](<https://obsidian.md/plugins?id=custom-sort>)
    - [File Tree Alternative](<https://obsidian.md/plugins?id=file-tree-alternative>)
    - [Obsidian Bartender](<https://github.com/nothingislost/obsidian-bartender>)
    - [MAKE.md](<https://obsidian.md/plugins?id=make-md>)
    )"

    HotPaste(text)
}

; Obsidian translation plugin quick links.
:*T0?:;obsitransl:: {
    text := "
    (
    - [Translate](<https://obsidian.md/plugins?id=translate>)
    - [Translator](<https://obsidian.md/plugins?id=obsidian-translator>)
    - [Language Translator](<https://obsidian.md/plugins?id=language-translator>)
    )"

    HotPaste(text)
}

; Demonstration of Markdown link and Wikilink syntaxes
:*T0?:;lnks:: {
    text := "
    (
    > Markdown: ``[link text](target)``
    > Wikilink: ``[[target|link text]]``
    > - [Reference](<https://help.obsidian.md/Linking+notes+and+files/Internal+links>) 
    )"

    HotPaste(text)
}