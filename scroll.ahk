#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

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
