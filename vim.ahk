#Include desktop_switcher.ahk
#Include portrait_snap.ahk

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
!q::switchDesktopByNumber(1)
!e::switchDesktopByNumber(2)
!r::switchDesktopByNumber(3)
!f::switchDesktopByNumber(4)
!z::switchDesktopByNumber(5)
!c::switchDesktopByNumber(6)
!v::switchDesktopByNumber(7)

c::
{
    Send #{Tab}
}

;; Windows snapping to sides and maximizing
;; Make sure to turn off "show what I can snap next to it" in Windows' "multitasking settings"
!a::
{
    Send #{Left}
    return
}
!s::
{
    WinMaximize, A
    return
}
!d::
{
    Send #{Right}
    return
}
!w::
{
    WinRestore, A
    ResizeWin(0)
    return
}
!x::
{
    WinRestore, A
    ResizeWin(1)
    return
}

;; scrolling
s::WheelDown
a::WheelUp

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
!h:: 
{
    SendInput !{Left}
    return
}
x:: 
!l:: 
{
    SendInput !{Right}
    return
}
+z:: 
+!h:: 
{
    SendInput !^{Left}
    return
}
+x:: 
+!l:: 
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
!i:: 
{
    SendInput {Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}{Up}
    return
}
!u:: 
{
    SendInput {down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}{down}
    return
}

;; for Ditto
r::F13


CapsLock::Suspend Off
~*CapsLock Up::Suspend On
