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

; virtual desktops
a::
{
    SendInput ^#{Left}
    return
}
s::
{
    SendInput ^#{Right}
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

#IfWinExist




$*MButton Up::SetTimer, MBScroll, off

$*MButton::

KeyWait, MButton, T0.2
If ErrorLevel = 1
{
    counter := 0
    MouseGetPos, X1, Y1, , c, 2
    SetTimer, MBScroll, 20
}
Else
   Send {MButton}
return

MBScroll:
    MouseGetPos, X2, Y2
    deltay := Abs(Y2-Y1) 
    deltax := Abs(X2-X1)
    If deltay >= 1
    {
        speed := 0
        counter := counter + 1
        if deltay > 16
        {
          speed := 3
        } 
        else if deltay > 12
        {
          speed := 1
        }
        else if deltay > 8 
        {
          if mod(counter,2) == 0
          {
            speed := 1
          }
        }
        else if deltay > 4
        {
          if mod(counter,3) == 0
          {
            speed := 1
          }
        }
        else 
        {
          if mod(counter,4) == 0
          {
            speed := 1
          }
        }
        Loop, % speed {
            SendInput, % "{Blind}{Wheel" (Y2 > Y1 ? "Down}" : "Up}")
        }
        MouseMove, 0, % Y1 - Y2, 0, R
    }
    If deltax >= 1
    {
      If (X2 > X1)
      {
          SendMessage, 0x114, 1, 0, %control%, A ; 0x114 is WM_HSCROLL
      }
      Else
      {
          SendMessage, 0x114, 0, 0, %control%, A ; 0x114 is WM_HSCROLL
      }   
      MouseMove, % X1 - X2, 0, 0, R
    }    
    return
