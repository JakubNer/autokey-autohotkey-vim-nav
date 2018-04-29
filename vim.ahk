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
  }
  return
}

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
      alt_mode := false
      return
    }
}
1::
{
    if (alt_mode) {
      restore(17)
      alt_mode := false
      return
    }
}
+2::
{
    if (alt_mode) {
      memorize(18,"2")
      alt_mode := false
      return
    }
}
2::
{
    if (alt_mode) {
      restore(18)
      alt_mode := false
      return
    }
}
+3::
{
    if (alt_mode) {
      memorize(19,"3")
      alt_mode := false
      return
    }
}
3::
{
    if (alt_mode) {
      restore(19)
      alt_mode := false
      return
    }
}
+4::
{
    if (alt_mode) {
      memorize(20,"4")
      alt_mode := false
      return
    }
}
4::
{
    if (alt_mode) {
      restore(20)
      alt_mode := false
      return
    }
}
+5::
{
    if (alt_mode) {
      memorize(21,"5")
      alt_mode := false
      return
    }
}
5::
{
    if (alt_mode) {
      restore(21)
      alt_mode := false
      return
    }
}
a::
{
    if (alt_mode) {
      restore(1)
      alt_mode := false
      return
    }
    SendInput {WheelUp}
    return
}
+a::
{
    if (alt_mode) {
      memorize(1,"a")    
      alt_mode := false
      return
    }
}
b::
{
    if (alt_mode) {
      restore(16)
      alt_mode := false
      return
    }
    SendInput {PgUp}
    return
}
+b::
{
    if (alt_mode) {
      memorize(16,"b")
      alt_mode := false
      return
    }  
}
+c::
{
    if (alt_mode) {
      memorize(7,"c")
      alt_mode := false
      return
    }
}
c::
{
    if (alt_mode) {
      restore(7)
      alt_mode := false
      return
    }
}
d::
{
    if (alt_mode) {
      restore(3)
      alt_mode := false
      return
    }
    SendInput {Delete}
    return
}
+d::
{
    if (alt_mode) {
      memorize(3,"d")
      alt_mode := false
      return
    }
    SendInput +{Delete}
    return
}
e::
{
    if (alt_mode) {
      SendEvent {LWin down}{Right down}{LWin up}{Right up}
      alt_mode := false
      return
    }
    SendInput ^{Up}
    return
}
f::
{
    if (alt_mode) {
      restore(4)
      alt_mode := false
      return
    }
    SendInput {PgDn}
    return
}
+f::
{
    if (alt_mode) {
      memorize(4,"f")
      alt_mode := false
      return
    }
}
g::
{
    if (alt_mode) {
      restore(15)
      alt_mode := false
      return
    }
    SendInput ^{Home}
    return
}
+g::
{
    if (alt_mode) {
      memorize(15,"g")
      alt_mode := false
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
      alt_mode := false
      return
    }
    SendInput {Up}{Up}{Up}{Up}{Up}
    return
}
+i::
{
    if (alt_mode) {
      memorize(10,"i")
      alt_mode := false
      return
    }
    SendInput +{Up}+{Up}+{Up}+{Up}+{Up}
    return
}
j::
{
    if (alt_mode) {
      restore(12)
      alt_mode := false
      return
    }
    SendInput {Down}
    return
}
+j::
{
    if (alt_mode) {
      memorize(12,"j")
      alt_mode := false
      return
    }
    SendInput +{Down}
    return
}
k::
{
    if (alt_mode) {
      restore(13)
      alt_mode := false
      return
    }
    SendInput {Up}
    return
}
+k::
{
    if (alt_mode) {
      memorize(13,"k")
      alt_mode := false
      return
    }
    SendInput +{Up}
    return
}
l::
{
    if (alt_mode) {
      restore(14)
      alt_mode := false
      return
    }
    SendInput {Right}
    return
}
+l::
{
    if (alt_mode) {
      memorize(14,"l")
      alt_mode := false
      return
    }
    SendInput +{Right}
    return
}
+o::
{
    if (alt_mode) {
      memorize(11,"o")
      alt_mode := false
      return
    }
}
o::
{
    if (alt_mode) {
      restore(11)
      alt_mode := false
      return
    }
}
q::
{
    if (alt_mode) {
      SendEvent {LWin down}{Left down}{LWin up}{Left up}
      alt_mode := false
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
        ;; CAPS-ALT-Q x 2 to restore top 4 windows from being snapped to corners
        RestoreFromTopFourToCorners()
      }
      Else 
      {
        ;;  CAPS-ALT-Q to make top 4 windows (in ALT TAB order) to snap into screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.
        TopFourToCorners()
      }     
      alt_mode := false
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
      alt_mode := false
      return
    }
    SendInput {WheelDown}
    return
}
+s::
{
    if (alt_mode) {
      memorize(2,"s")
      alt_mode := false
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
      alt_mode := false
      return
    }
    return
}
u::
{
    if (alt_mode) {
      restore(9)
      alt_mode := false
      return
    }
    SendInput {down}{down}{down}{down}{down}
    return
}
+u::
{
    if (alt_mode) {
      memorize(9,"u")
      alt_mode := false
      return
    }
    SendInput +{down}+{down}+{down}+{down}+{down}
    return
}
+v::
{
    if (alt_mode) {
      memorize(8,"v")
      alt_mode := false
      return
    }
}    
v::
{
    if (alt_mode) {
      restore(8)
      alt_mode := false
      return
    }
}
w::
{
    if (alt_mode) {
      WinMaximize, A
      alt_mode := false
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
      alt_mode := false
      return
    }
    SendInput !{Right}
    return
}
+x::
{
    if (alt_mode) {
      memorize(6,"x")
      alt_mode := false
      return
    }
    SendInput !^{Right}
    return
}
y::
{
    if (alt_mode) {
      app_mem_info()
      alt_mode := false
      return
    }
    SendInput ^{Down}
    return
}
z::
{
    if (alt_mode) {
      restore(5)
      alt_mode := false
      return
    }
    SendInput !{Left}
    return
}
+z::
{
    if (alt_mode) {
      memorize(5,"z")
      alt_mode := false
      return
    }
    SendInput !^{Left}
    return
}

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
