#Include app_memorize_restore.ahk

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
DetectHiddenWindows, On
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetBatchLines -1
ListLines Off

SetCapsLockState, AlwaysOff

Suspend On

; avoid bad state of CAPS pressed when not down
GetKeyState, state, CapsLock
if state = D
{
  Suspend On
  SetCapsLockState, off
  Send {CapsLock Up}
}

; Virtual Desktops
+!a::memorize(1)
!a::restore(1)
+!s::memorize(2)
!s::restore(2)
+!d::memorize(3)
!d::restore(3)
+!f::memorize(4)
!f::restore(4)
+!z::memorize(5)
!z::restore(5)
+!x::memorize(6)
!x::restore(6)
+!c::memorize(7)
!c::restore(7)
+!v::memorize(8)
!v::restore(8)
+!u::memorize(9)
!u::restore(9)
+!i::memorize(10)
!i::restore(10)
+!o::memorize(11)
!o::restore(11)
+!j::memorize(12)
!j::restore(12)
+!k::memorize(13)
!k::restore(13)
+!l::memorize(14)
!l::restore(14)
+!g::memorize(15)
!g::restore(15)
+!b::memorize(16)
!b::restore(16)
+!1::memorize(17)
!1::restore(17)
+!2::memorize(18)
!2::restore(18)
+!3::memorize(19)
!3::restore(19)
+!4::memorize(20)
!4::restore(20)
+!5::memorize(21)
!5::restore(21)

;; Windows snapping to sides and maximizing
;; Make sure to turn off "show what I can snap next to it" in Windows' "multitasking settings"
!q::
{
    SendEvent {LWin down}{Left down}{LWin up}{Left up}
    return
}
!w::
{
    WinMaximize, A
    return
}
!e::
{
    SendEvent {LWin down}{Right down}{LWin up}{Right up}
    return
}
!r::
{
    WinMinimize, A
    return
}
!t::
{
    if toggle_taskbar := !toggle_taskbar

       WinHide ahk_class Shell_TrayWnd

    else

       WinShow ahk_class Shell_TrayWnd

    return
}

;; scrolling
s::
{
    SendInput {WheelDown}
    return
}

a::
{
    SendInput {WheelUp}
    return
}

; cursor movements
h::
{
    SendInput {Left}
    return
}
j::
{
    SendInput {Down}
    return
}
k::
{
    SendInput {Up}
    return
}
l::
{
    SendInput {Right}
    return
}
g::
{
    SendInput ^{Home}
    return
}
+g::
{
    SendInput ^{End}
    return
}
b::
{
    SendInput {PgUp}
    return
}
f::
{
    SendInput {PgDn}
    return
}
e::
{
    SendInput ^{Up}
    return
}
y::
{
    SendInput ^{Down}
    return
}

; page movements
w::
{
    SendInput ^{Right}
    return
}
q::
{
    SendInput ^{Left}
    return
}
d::
{
    SendInput {Delete}
    return
}
0::
{
    SendInput {Home}
    return
}
-::
{
    SendInput {End}
    return
}
$::
{
    SendInput {End}
    return
}

; selection movements with Shift
+h::
{
    SendInput +{Left}
    return
}
+j::
{
    SendInput +{Down}
    return
}
+k::
{
    SendInput +{Up}
    return
}
+l::
{
    SendInput +{Right}
    return
}
+w::
{
    SendInput +^{Right}
    return
}
+q::
{
    SendInput +^{Left}
    return
}
+d::
{
    SendInput +{Delete}
    return
}
)::
{
    SendInput +{Home}
    return
}
_::
{
    SendInput +{End}
    return
}

; Browser back/forward
z::
{
    SendInput !{Left}
    return
}
x::
{
    SendInput !{Right}
    return
}
+z::
{
    SendInput !^{Left}
    return
}
+x::
{
    SendInput !^{Right}
    return
}
i::
{
    SendInput {Up}{Up}{Up}{Up}{Up}
    return
}
u::
{
    SendInput {down}{down}{down}{down}{down}
    return
}
+i::
{
    SendInput +{Up}+{Up}+{Up}+{Up}+{Up}
    return
}
+u::
{
    SendInput +{down}+{down}+{down}+{down}+{down}
    return
}

;; for Ditto
r::F13


CapsLock::Suspend Off
~*CapsLock Up::Suspend On
