; enable directives if not including in another script
; #Requires AutoHotkey v2.0+
; #SingleInstance

; === Box Drawing ===

; upper/top left corner
:*T?:;bxul::┌

; upper/top right corner
:*T?:;bxur::┐

; lower/bottom left corner
:*T?:;bxll::└

; lower/bottom right corner
:*T?:;bxlr::┘

; horizontal line
:*T?:;bxh::─

; vertical line
:*T?:;bxv::│

; vertical with left stem
:*T?:;bxsteml::┤

; vertical with right stem
:*T?:;bxstemr::├

; horizontal with upper/top stem
:*T?:;bxstemu::┴

; horizontal with lower/bottom stem
:*T?:;bxstemd::┬

; crossed horizontal and vertical
:*T?:;bxcross::┼