#Include desktop_switcher.ahk
#Include portrait_snap.ahk
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
!a::memorizeOrRestore(1,"!a")
!s::memorizeOrRestore(2,"!s")
!d::memorizeOrRestore(3,"!d")
!f::memorizeOrRestore(4,"!f")
!z::memorizeOrRestore(5,"!z")
!x::memorizeOrRestore(6,"!x")
!c::memorizeOrRestore(7,"!c")
!v::memorizeOrRestore(8,"!v")
!u::memorizeOrRestore(9,"!u")
!i::memorizeOrRestore(10,"!i")
!o::memorizeOrRestore(11,"!o")
!j::memorizeOrRestore(12,"!j")
!k::memorizeOrRestore(13,"!k")
!l::memorizeOrRestore(14,"!l")
!g::memorizeOrRestore(15,"!g")
!b::memorizeOrRestore(16,"!b")

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
0:: ; Add to the inputNumber if inputNumber != null, otherwise HOME
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

;; for Ditto
r::F13


CapsLock::Suspend Off
~*CapsLock Up::Suspend On
