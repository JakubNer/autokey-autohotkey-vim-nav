#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
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

; 7+ taskbar tweak task switch: map F14 (0x7D) to 7+tt action 101, F15 (0x7E) to 7+tt action 102 (in advanced options/keyboard shortcuts)
a::F14
s::F15

; win10 select taskbar apps
1::#1
2::#2
3::#3
4::#4
5::#5
6::#6
7::#7
8::#8
9::#9
0::#0

; win10 window management 
MButton::
{
    WinMaximize, A
    return
}
RButton::
{
    Send #{Right}
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

r::F13

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
