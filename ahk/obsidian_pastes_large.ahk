; enable directives if not including in another script
; #Requires AutoHotkey v2.0+
; #SingleInstance
; #Include "%A_ScripDir%"
; #Include "functions.ahk"

; === Obsidian big pastes ===

:*T0?:;pmdb:: { ; basic Markdown resources
    text := "
    (
    ### Markdown Resources
    - [Obsidian Basic Formatting](<https://help.obsidian.md/Editing+and+formatting/Basic+formatting+syntax>) | Learn many of the basics of Markdown in Obsidian.
    - [Markdown Guide](<https://www.markdownguide.org/basic-syntax>) | Learn more about how Markdown renders various elements by syntax.
    )"

    HotPaste(text)
}
:*T0?:;pmdf:: { ; full Markdown resources
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

:*T0?:;obsicol:: { ; Obsidian multi-column formatting quick links.
    text := "
    (
    - [efemkay's modular CSS](<https://github.com/efemkay/obsidian-modular-css-layout>)
    - [Multi-Column Markdown](<https://obsidian.md/plugins?id=multi-column-markdown>)
    - [Obsidian Columns](<https://obsidian.md/plugins?id=obsidian-columns>)
    )"

    HotPaste(text)
}

:*T0?:;obsitree:: { ; Obsidian file tree plugin quick links.
    text := "
    (
    - [Custom Sort](<https://obsidian.md/plugins?id=custom-sort>)
    - [File Tree Alternative](<https://obsidian.md/plugins?id=file-tree-alternative>)
    - [Obsidian Bartender](<https://github.com/nothingislost/obsidian-bartender>)
      - requires [BRAT](<https://obsidian.md/plugins?id=obsidian42-brat>)
    - [MAKE.md](<https://obsidian.md/plugins?id=make-md>)
    )"

    HotPaste(text)
}

:*T0?:;obsitransl:: { ; Obsidian translation plugin quick links.
    text := "
    (
    - [Translate](<https://obsidian.md/plugins?id=translate>)
    - [Translator](<https://obsidian.md/plugins?id=obsidian-translator>)
    - [Language Translator](<https://obsidian.md/plugins?id=language-translator>)
    )"

    HotPaste(text)
}

:*T0?:;obsifolder:: { ; Obsidian folder note plugin quick links.
    text := "
    (
    ### Folder Notes Themselves
    - [Folder Notes](<https://obsidian.md/plugins?id=folder-notes>)
    - [Folder Index](<https://obsidian.md/plugins?id=obsidian-folder-index>)
    - [AidenLx's Folder Note](<https://obsidian.md/plugins?id=alx-folder-note>)
      - requires [Folder Note Core](<https://obsidian.md/plugins?id=folder-note-core>) if i understand correctly
    ### Auto-Linking
    - [Waypoint](<https://obsidian.md/plugins?id=waypoint>) (for use with AidenLx's, unsure of interaction with others)
    )"

    HotPaste(text)
}

:*T0?:;lnks:: { ; Demonstration of Markdown link and Wikilink syntaxes
    text := "
    (
    > Markdown: ``[link text](target)``
    > Wikilink: ``[[target|link text]]``
    > - [Reference](<https://help.obsidian.md/Linking+notes+and+files/Internal+links>) 
    )"

    HotPaste(text)
}

:*T0?:;obsearch:: { ; Obsidian quick link Search on help site
    HotPaste("[Search](<https://help.obsidian.md/Plugins/Search>)")
}

:*T0?:;obsuri:: { ; Obsidian quick link URI on help site
    HotPaste("[Obsidian URI](<https://help.obsidian.md/Concepts/Obsidian+URI>)")
}