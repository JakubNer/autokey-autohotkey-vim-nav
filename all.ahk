#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; HotKey to Initiate CAPSLOCK {{{
CAPSLOCK::
    {                                
        Gui, 99:+ToolWindow
        Gui, 99:Show,NoActivate x-1 w1, Capslock Is Down
        keywait, Capslock
        Gui, 99:Destroy
    }
Return ; }}}

#IfWinExist, Capslock Is Down

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

; https://autohotkey.com/board/topic/30816-simulate-scroll-wheel-using-right-mouse-button/
$*MButton::
Hotkey, $*MButton Up, MButtonup, off
;KeyWait, MButton, T0.4
;If ErrorLevel = 1
;{
   Hotkey, $*MButton Up, MButtonup, on
   MouseGetPos, ox, oy
   SetTimer, WatchTheMouse, 5
   movedx := 0
   movedy := 0
   pixelsMoved := 0
;   TrayTip, Scrolling started, Emulating scroll wheel
;}
;Else
;   Send {MButton}
return

MButtonup:
Hotkey, $*MButton Up, MButtonup, off
SetTimer, WatchTheMouse, off
;TrayTip
If (pixelsMoved = 0)
{
    ;The mouse was not moved, send the click event
    ; (Default action is 'Back', replace these with a different action here if desired)
    Send {MButton}
    Send {MButtonUp}
}
return

WatchTheMouse:
MouseGetPos, nx, ny
movedx := movedx+nx-ox
movedy := movedy+ny-oy

pixelsMoved := pixelsMoved + Abs(nx-ox) + Abs(ny-oy)

timesX := Abs(movedx) / 4
ControlGetFocus, control, A
Loop, %timesX%
{
    If (movedx > 0)
    {
        SendMessage, 0x114, 1, 0, %control%, A ; 0x114 is WM_HSCROLL
        movedx := movedx - 4
    }
    Else
    {
        SendMessage, 0x114, 0, 0, %control%, A ; 0x114 is WM_HSCROLL
        movedx := movedx + 4
    }
}

timesY := Abs(movedy) / 4
Loop, %timesY%
{
    If (movedy > 0)
    {
        Click WheelDown
        movedy := movedy - 4
    }
    Else
    {
        Click WheelUp
        movedy := movedy + 4
    }
}   

MouseMove ox, oy
return

#IfWinExist