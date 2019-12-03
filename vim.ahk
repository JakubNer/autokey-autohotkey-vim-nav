#Include utils.ahk
#Include app_memorize_restore.ahk
#Include app_switch_by_name.ahk
#Include window.ahk
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
1::
{
    if (alt_mode) {
      memorize("1")          
      return
    }
	return
}
!1::
{
	restoreall("1")
	return
}
2::
{
    if (alt_mode) {
      memorize("2")          
      return
    }
	return
}
!2::
{
	restoreall("2")
	return
}
3::
{
    if (alt_mode) {
      memorize("3")
      return
    }
	return
}
!3:: 
{
	restoreall("3")
    return
}
4::
{
    if (alt_mode) {
      memorize("4")          
      return
    }
	return
}
!4:: 
{
	restoreall("4")
    return
}
5::
{
    if (alt_mode) {
      memorize("5")          
      return
    }
	return	
}
!5::
{
	restoreall("5")
    return
}
a::
{
    if (alt_mode) {
        run("a")
        return
    }
    while GetKeyState("a", "P")
    {
      Send {WheelUp}
      Sleep, 45
    }
    return
}
!a:: 
{
	KeyWait, a
	KeyWait, a, D T.3
	If (!ErrorLevel) {
		switchImmediate("a")
	} Else {
		switch("a")
	}
    return
}
b::
{
    if (alt_mode) {
        run("b")
        return
    }
    SendInput {PgUp}
    return
}
!b:: 
{
	KeyWait, b
	KeyWait, b, D T.3
	If (!ErrorLevel) {
		switchImmediate("b")
	} Else {
		switch("b")
	}
    return
}
c::
{
    if (alt_mode) {
        run("c")
        return
    }
    SendInput !{Left}
    return
}
!c::
{
	KeyWait, c
	KeyWait, c, D T.3
	If (!ErrorLevel) {
		switchImmediate("c")
	} Else {
		switch("c")
	}
    return
}
+c::
{
    SendInput !^{Left}
    return
}
d::
{
    if (alt_mode) {
		run("d")		
        return
    }
    SendInput {Delete}
    return
}
+d::
{
    SendInput +{Delete}
    return
}
!d:: 
{
	KeyWait, d
	KeyWait, d, D T.3
	If (!ErrorLevel) {
		switchImmediate("d")
	} Else {
		switch("d")
	}
    return
}
e::
{
    SendInput ^{Up}
    return
}
!e:: 
{
	KeyWait, e
	KeyWait, e, D T.3
	If (!ErrorLevel) {
		ResizeWin(1,0)
		centerMouse()
	}
	else {
		WinRestore, A
		SendEvent {LWin down}{Right down}{LWin up}{Right up}      
		centerMouse()
	}
    return
}
f::
{
    if (alt_mode) {
        run("f")
        return
    }
    SendInput {PgDn}
    return
}
!f:: 
{
	KeyWait, f
	KeyWait, f, D T.3
	If (!ErrorLevel) {
		switchImmediate("f")
	} Else {
		switch("f")
	}
    return
}
g::
{
    if (alt_mode) {
        run("g")
        return
    }
    SendInput ^{Home}
    return
}
+g::
{
    SendInput ^{End}
    return
}
!g:: 
{
	KeyWait, g
	KeyWait, g, D T.3
	If (!ErrorLevel) {
		switchImmediate("g")
	} Else {
		switch("g")
	}
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
    SendInput ^{Left}
    return
}
+q::
{
    SendInput +^{Left}
    return
}
!q:: 
{
	KeyWait, q
	KeyWait, q, D T.3
	If (!ErrorLevel) {
		ResizeWin(0,0)
		centerMouse()
	}
	else {
		WinRestore, A
		SendEvent {LWin down}{Left down}{LWin up}{Left up}      
		centerMouse()
	}
    return
}
r::
{
    ;; for Ditto
    SendInput {F13}
    return
}
!r::
{
    SendEvent {LWin down}{Down down}{LWin up}{Down up}      
	centerMouse()
    return
}
!`::
{
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
s::
{
    if (alt_mode) {
        run("s")
        return
    }
    while GetKeyState("s", "P")
    {
      Send {WheelDown}
      Sleep, 45
    }
    return
}
!s:: 
{
	KeyWait, s
	KeyWait, s, D T.3
	If (!ErrorLevel) {
		switchImmediate("s")
	} Else {
		switch("s")
	}
    return
}
!t::
{
    SendInput #+{Right}
	centerMouse()
	return
}
+!t::
{
    if toggle_taskbar := !toggle_taskbar {
        WinHide ahk_class Shell_TrayWnd
    } else {
        WinShow ahk_class Shell_TrayWnd
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
v::
{
    if (alt_mode) {
        run("v")
        return
    }
    SendInput !{Right}
    return
}
!v::
{
	KeyWait, v
	KeyWait, v, D T.3
	If (!ErrorLevel) {
		switchImmediate("v")
	} Else {
		switch("v")
	}
    return
}
+v::
{
    SendInput !^{Right}
    return
}
w::
{
    SendInput ^{Right}
    return
}
+w::
{
    SendInput +^{Right}
    return
}
!w::
{
    KeyWait, w
    KeyWait, w, D T.3
    If (!ErrorLevel)
    {
      ;; CAPS-W x 2 to snap down
	  WinMaximize, A
    }
    Else 
    {
      ;;  CAPS-W to snap up
      SendEvent {LWin down}{Up down}{LWin up}{Up up}      
    }           
	centerMouse()
    return
}
x::
{
    if (alt_mode) {
        run("x")
        return
    }
    while GetKeyState("x", "P")
    {
	  Send {WheelRight}
      Sleep, 45
    }

	return
}
!x:: 
{
	KeyWait, x
	KeyWait, x, D T.3
	If (!ErrorLevel) {
		switchImmediate("x")
	} Else {
		switch("x")
	}
    return
}
y::
{
    SendInput ^{Down}
    return
}
z::
{
    if (alt_mode) {
        run("z")
        return
    }
    while GetKeyState("z", "P")
    {
	  Send {WheelLeft}
      Sleep, 45
    }	
	return
}
!z:: 
{
	KeyWait, z
	KeyWait, z, D T.3
	If (!ErrorLevel) {
		switchImmediate("z")
	} Else {
		switch("z")
	}
    return
}
!LEFT::
{
    SendInput #+{Left}
	centerMouse()
	return
}
!RIGHT::
{
    SendInput #+{Right}
	centerMouse()
	return
}

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
