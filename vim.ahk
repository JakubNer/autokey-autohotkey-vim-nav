#Include app_memorize_restore.ahk
#Include window.ahk

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

;; modifier into alt_mode
space::
{
  if (alt_mode) {
    alt_mode := false
  } else {
    alt_mode := true
    SetTimer, alt_mode_off, 1000 
  }
  return
}

alt_mode_off:
    alt_mode := false
return

;; modifier into alt_mode2
tab::
{
  if (alt_mode2) {
    alt_mode2 := false
  } else {
    alt_mode2 := true
    SetTimer, alt_mode2_off, 1000 
  }
  return
}

alt_mode2_off:
    alt_mode2 := false
return

-::
{
    SendInput {End}
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
0::
{
    SendInput {Home}
    return
}  
+1::
{
    if (alt_mode) {
      memorize(17,"1")     
      return
    }
    if (alt_mode2) {
      memorize(26,"+1")          
      return
    }    
}
1::
{
    if (alt_mode) {
      restore(17)     
      return
    }
    if (alt_mode2) {
      restore(26)      
      return
    }    
}
+2::
{
    if (alt_mode) {
      memorize(18,"2")      
      return
    }
    if (alt_mode2) {
      memorize(27,"+2")          
      return
    }    
}
2::
{
    if (alt_mode) {
      restore(18)      
      return
    }
    if (alt_mode2) {
      restore(27)      
      return
    }    
}
+3::
{
    if (alt_mode) {
      memorize(19,"3")      
      return
    }
    if (alt_mode2) {
      memorize(28,"+3")          
      return
    }    
}
3::
{
    if (alt_mode) {
      restore(19)      
      return
    }
    if (alt_mode2) {
      restore(28)      
      return
    }    
}
+4::
{
    if (alt_mode) {
      memorize(20,"4")      
      return
    }
    if (alt_mode2) {
      memorize(29,"+4")          
      return
    }    
}
4::
{
    if (alt_mode) {
      restore(20)      
      return
    }
    if (alt_mode2) {
      restore(29)      
      return
    }    
}
+5::
{
    if (alt_mode) {
      memorize(21,"5")      
      return
    }
    if (alt_mode2) {
      memorize(30,"+5")          
      return
    }    
}
5::
{
    if (alt_mode) {
      restore(21)      
      return
    }
    if (alt_mode2) {
      restore(30)      
      return
    }    
}
a::
{
    if (alt_mode) {
      restore(1)      
      return
    }
    if (alt_mode2) {
      restore(9)      
      return
    }
    while GetKeyState("a", "P")
    {
      Send {WheelUp}
      Sleep, 45
    }
    return
}
+a::
{
    if (alt_mode) {
      memorize(1,"a")          
      return
    }
    if (alt_mode2) {
      memorize(9,"+a")          
      return
    }
}
b::
{
    if (alt_mode) {
      restore(16)      
      return
    }
    if (alt_mode2) {
      restore(25)      
      return
    }    
    SendInput {PgUp}
    return
}
+b::
{
    if (alt_mode) {
      memorize(16,"b")      
      return
    }  
    if (alt_mode2) {
      memorize(25,"+b")          
      return
    }    
}
+c::
{
    if (alt_mode) {
      memorize(7,"c")      
      return
    }
    if (alt_mode2) {
      memorize(23,"+c")          
      return
    }    
}
c::
{
    if (alt_mode) {
      restore(7)      
      return
    }
    if (alt_mode2) {
      restore(23)      
      return
    }    
}
d::
{
    if (alt_mode) {
      restore(3)      
      return
    }
    if (alt_mode2) {
      restore(11)      
      return
    }    
    SendInput {Delete}
    return
}
+d::
{
    if (alt_mode) {
      memorize(3,"d")      
      return
    }
    if (alt_mode2) {
      memorize(11,"+d")          
      return
    }
    SendInput +{Delete}
    return
}
e::
{
    if (alt_mode) {
      SendEvent {LWin down}{Right down}{LWin up}{Right up}      
      return
    }
    SendInput ^{Up}
    return
}
f::
{
    if (alt_mode) {
      restore(4)      
      return
    }
    if (alt_mode2) {
      restore(12)      
      return
    }
    SendInput {PgDn}
    return
}
+f::
{
    if (alt_mode) {
      memorize(4,"f")      
      return
    }
    if (alt_mode2) {
      memorize(12,"+f")          
      return
    }
}
g::
{
    if (alt_mode) {
      restore(15)      
      return
    }
    if (alt_mode2) {
      restore(13)      
      return
    }
    SendInput ^{Home}
    return
}
+g::
{
    if (alt_mode) {
      memorize(15,"g")      
      return
    }
    if (alt_mode2) {
      memorize(13,"+g")          
      return
    }
    SendInput ^{End}
    return
}
h::
{
    SendInput {Left}
    return
}
+h::
{
    SendInput +{Left}
    return
}
i::
{
    SendInput {Up}{Up}{Up}{Up}{Up}
    return
}
+i::
{
    SendInput +{Up}+{Up}+{Up}+{Up}+{Up}
    return
}
j::
{
    SendInput {Down}
    return
}
+j::
{
    SendInput +{Down}
    return
}
k::
{
    SendInput {Up}
    return
}
+k::
{
    SendInput +{Up}
    return
}
l::
{
    SendInput {Right}
    return
}
+l::
{
    SendInput +{Right}
    return
}
q::
{
    if (alt_mode) {
      SendEvent {LWin down}{Left down}{LWin up}{Left up}      
      return
    }
    SendInput ^{Left}
    return
}
+q::
{
    SendInput +^{Left}
    return
}
r::
{
    if (alt_mode) {
      ;; Windows snapping to sides and maximizing
      ;; Make sure to turn off "show what I can snap next to it" in Windows' "multitasking settings"
      KeyWait, r
      KeyWait, r, D T.3
      If (!ErrorLevel)
      {
        ;; CAPS-R x 2 to restore top 4 windows from being snapped to corners
        RestoreFromTopFourToCorners()
      }
      Else 
      {
        ;;  CAPS-R to make top 4 windows (in ALT TAB order) to snap into screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.
        TopFourToCorners()
      }           
      return
    }
    ;; for Ditto
    SendInput {F13}
    return
}
s::
{
    if (alt_mode) {
      restore(2)      
      return
    }
    if (alt_mode2) {
      restore(10)      
      return
    }
    while GetKeyState("s", "P")
    {
      Send {WheelDown}
      Sleep, 45
    }
    return
}
+s::
{
    if (alt_mode) {
      memorize(2,"s")      
      return
    }
    if (alt_mode2) {
      memorize(10,"+s")          
      return
    }
}
t::
{
    if (alt_mode) {
      if toggle_taskbar := !toggle_taskbar {
         WinHide ahk_class Shell_TrayWnd
      } else {
         WinShow ahk_class Shell_TrayWnd
      }      
      return
    }
    return
}
u::
{
    SendInput {down}{down}{down}{down}{down}
    return
}
+u::
{
    SendInput +{down}+{down}+{down}+{down}+{down}
    return
}
+v::
{
    if (alt_mode) {
      memorize(8,"v")      
      return
    }
    if (alt_mode2) {
      memorize(24,"+v")          
      return
    }

}    
v::
{
    if (alt_mode) {
      restore(8)      
      return
    }
    if (alt_mode2) {
      restore(24)      
      return
    }    
}
w::
{
    if (alt_mode) {
      WinMaximize, A      
      return
    }
    SendInput ^{Right}
    return
}
+w::
{
    SendInput +^{Right}
    return
}
x::
{
    if (alt_mode) {
      restore(6)      
      return
    }
    if (alt_mode2) {
      restore(22)      
      return
    }
    SendInput !{Right}
    return
}
+x::
{
    if (alt_mode) {
      memorize(6,"x")      
      return
    }
    if (alt_mode2) {
      memorize(22,"+x")          
      return
    }
    SendInput !^{Right}
    return
}
y::
{
    if (alt_mode) {
      app_mem_info()      
      return
    }
    SendInput ^{Down}
    return
}
z::
{
    if (alt_mode) {
      restore(5)      
      return
    }
    if (alt_mode2) {
      restore(14)      
      return
    }
    SendInput !{Left}
    return
}
+z::
{
    if (alt_mode) {
      memorize(5,"z")      
      return
    }
    if (alt_mode2) {
      memorize(14,"+a")          
      return
    }
    SendInput !^{Left}
    return
}

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
