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
}
1::
{
    if (alt_mode) {
      restore(17)     
      return
    }
}
+2::
{
    if (alt_mode) {
      memorize(18,"2")      
      return
    }
}
2::
{
    if (alt_mode) {
      restore(18)      
      return
    }
}
+3::
{
    if (alt_mode) {
      memorize(19,"3")      
      return
    }
}
3::
{
    if (alt_mode) {
      restore(19)      
      return
    }
}
+4::
{
    if (alt_mode) {
      memorize(20,"4")      
      return
    }
}
4::
{
    if (alt_mode) {
      restore(20)      
      return
    }
}
+5::
{
    if (alt_mode) {
      memorize(21,"5")      
      return
    }
}
5::
{
    if (alt_mode) {
      restore(21)      
      return
    }
}
a::
{
    if (alt_mode) {
      restore(1)      
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
}
b::
{
    if (alt_mode) {
      restore(16)      
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
}
+c::
{
    if (alt_mode) {
      memorize(7,"c")      
      return
    }
}
c::
{
    if (alt_mode) {
      restore(7)      
      return
    }
}
d::
{
    if (alt_mode) {
      restore(3)      
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
    SendInput {PgDn}
    return
}
+f::
{
    if (alt_mode) {
      memorize(4,"f")      
      return
    }
}
g::
{
    if (alt_mode) {
      restore(15)      
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
    if (alt_mode) {
      restore(10)      
      return
    }
    SendInput {Up}{Up}{Up}{Up}{Up}
    return
}
+i::
{
    if (alt_mode) {
      memorize(10,"i")      
      return
    }
    SendInput +{Up}+{Up}+{Up}+{Up}+{Up}
    return
}
j::
{
    if (alt_mode) {
      restore(12)      
      return
    }
    SendInput {Down}
    return
}
+j::
{
    if (alt_mode) {
      memorize(12,"j")      
      return
    }
    SendInput +{Down}
    return
}
k::
{
    if (alt_mode) {
      restore(13)      
      return
    }
    SendInput {Up}
    return
}
+k::
{
    if (alt_mode) {
      memorize(13,"k")      
      return
    }
    SendInput +{Up}
    return
}
l::
{
    if (alt_mode) {
      restore(14)      
      return
    }
    SendInput {Right}
    return
}
+l::
{
    if (alt_mode) {
      memorize(14,"l")      
      return
    }
    SendInput +{Right}
    return
}
+o::
{
    if (alt_mode) {
      memorize(11,"o")      
      return
    }
}
o::
{
    if (alt_mode) {
      restore(11)      
      return
    }
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
    if (alt_mode) {
      restore(9)      
      return
    }
    SendInput {down}{down}{down}{down}{down}
    return
}
+u::
{
    if (alt_mode) {
      memorize(9,"u")      
      return
    }
    SendInput +{down}+{down}+{down}+{down}+{down}
    return
}
+v::
{
    if (alt_mode) {
      memorize(8,"v")      
      return
    }
}    
v::
{
    if (alt_mode) {
      restore(8)      
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
    SendInput !{Right}
    return
}
+x::
{
    if (alt_mode) {
      memorize(6,"x")      
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
    SendInput !{Left}
    return
}
+z::
{
    if (alt_mode) {
      memorize(5,"z")      
      return
    }
    SendInput !^{Left}
    return
}

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
