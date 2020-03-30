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

-::End

)::+Home

_::+End

0::Home

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

    Send {WheelUp}
	if (A_PriorHotkey = "a") {
      Sleep, 45
    }
    return
}
!a:: 
{
	If (toggleLastTime("a") < 300) {
		SWITCH_TO := false
		switchImmediate("a")
	} Else {
		SWITCH_TO := "a"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("b") < 300) {
		SWITCH_TO := false
		switchImmediate("b")
	} Else {
		SWITCH_TO := "b"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("c") < 300) {
		SWITCH_TO := false
		switchImmediate("c")
	} Else {
		SWITCH_TO := "c"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("d") < 300) {
		SWITCH_TO := false
		switchImmediate("d")
	} Else {
		SWITCH_TO := "d"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("f") < 300) {
		SWITCH_TO := false
		switchImmediate("f")
	} Else {
		SWITCH_TO := "f"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("g") < 300) {
		SWITCH_TO := false
		switchImmediate("g")
	} Else {
		SWITCH_TO := "g"
		SetTimer, SwitchToTimeout, 300
	}
    return
}

h::Left

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

j::Down

k::Up

l::Right

q::^Left

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

    Send {WheelDown}
    if (A_PriorHotkey = "s")
    {
      Sleep, 45
    }
    return
}
!s:: 
{
	If (toggleLastTime("s") < 300) {
		SWITCH_TO := false
		switchImmediate("s")
	} Else {
		SWITCH_TO := "s"
		SetTimer, SwitchToTimeout, 300
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
	If (toggleLastTime("v") < 300) {
		SWITCH_TO := false
		switchImmediate("v")
	} Else {
		SWITCH_TO := "v"
		SetTimer, SwitchToTimeout, 300
	}
    return
}
+v::
{
    SendInput !^{Right}
    return
}

w::^Right

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
    
	Send {WheelRight}
	if (A_PriorHotkey = "x") {
      Sleep, 45
    }

	return
}
!x:: 
{
	If (toggleLastTime("x") < 300) {
		SWITCH_TO := false
		switchImmediate("x")
	} Else {
		SWITCH_TO := "x"
		SetTimer, SwitchToTimeout, 300
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

    Send {WheelLeft}
	if (A_PriorHotkey = "z") {
      Sleep, 45
    }	
	return
}
!z:: 
{
	If (toggleLastTime("z") < 300) {
		SWITCH_TO := false
		switchImmediate("z")
	} Else {
		SWITCH_TO := "z"
		SetTimer, SwitchToTimeout, 300
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

SwitchToTimeout:
	if (SWITCH_TO) {
		switch(SWITCH_TO)
	}
	SetTimer,,off
return
