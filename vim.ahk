#Include utils.ahk
#Include app_memorize_restore.ahk
#Include app_switch_by_name.ahk
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
!space::
{
	global LIMITING_APP_IDS
	LIMITING_APP_IDS := []
	clearGroup()
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

LIMITING_APP_IDS := []

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
!F1::
{
  dump()
  return
}
0::
{
    SendInput {Home}
    return
}
!0:: 
{
	global LIMITING_APP_IDS
	LIMITING_APP_IDS := []
	clearGroup()	
	return
}
1::
{
    if (alt_mode) {
      memorize("1")          
      return
    }
    if (alt_mode2) {
      reset_memory("1")
      return
    }    
}
!1::
{
	global LIMITING_APP_IDS
	KeyWait, 1
	KeyWait, 1, D T.3
	If (!ErrorLevel)
	{
		restoreall("1")
    } else {
		if (A_ThisHotKey == A_PriorHotkey) {
			restoreone("1")
		}
	}
	LIMITING_APP_IDS := retrieve("1")
	writeGroup("1")
	return
}
2::
{
    if (alt_mode) {
      memorize("2")          
      return
    }
    if (alt_mode2) {
      reset_memory("2")
      return
    }    
}
!2::
{
	global LIMITING_APP_IDS
    KeyWait, 2
    KeyWait, 2, D T.3
    If (!ErrorLevel)
    {
		restoreall("2")
    } else {
		if (A_ThisHotKey == A_PriorHotkey) {
			restoreone("2")
		}
	}
	LIMITING_APP_IDS := retrieve("2")
	writeGroup("2")
	return
}
3::
{
    if (alt_mode) {
      memorize("3")
      return
    }
    if (alt_mode2) {
      reset_memory("3")
      return
    }    
}
!3:: 
{
	global LIMITING_APP_IDS
    KeyWait, 3
    KeyWait, 3, D T.3
    If (!ErrorLevel)
    {
		restoreall("3")
    } else {
		if (A_ThisHotKey == A_PriorHotkey) {
			restoreone("3")
		}
	}
	LIMITING_APP_IDS := retrieve("3")
	writeGroup("3")
    return
}
4::
{
    if (alt_mode) {
      memorize("4")          
      return
    }
    if (alt_mode2) {
      reset_memory("4")
      return
    }    
}
!4:: 
{
	global LIMITING_APP_IDS
    KeyWait, 4
    KeyWait, 4, D T.3
    If (!ErrorLevel)
    {
		restoreall("4")
    } else {
		if (A_ThisHotKey == A_PriorHotkey) {
			restoreone("4")
		}
	}
	LIMITING_APP_IDS := retrieve("4")
	writeGroup("4")
    return
}
5::
{
    if (alt_mode) {
      memorize("5")          
      return
    }
    if (alt_mode2) {
      reset_memory("5")
      return
    }    
}
!5::
{
	global LIMITING_APP_IDS
    KeyWait, 5
    KeyWait, 5, D T.3
    If (!ErrorLevel)
    {
		restoreall("5")
    } else {
		if (A_ThisHotKey == A_PriorHotkey) {	
			restoreone("5")
		}
	}
	LIMITING_APP_IDS := retrieve("5")
	writeGroup("5")
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
	global LIMITING_APP_IDS
    switch("a", LIMITING_APP_IDS)
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
	global LIMITING_APP_IDS
    switch("b", LIMITING_APP_IDS)
    return
}
c::
{
    if (alt_mode) {
        run("c")
        return
    }
}
!c::
{
	global LIMITING_APP_IDS
    switch("c", LIMITING_APP_IDS)
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
	global LIMITING_APP_IDS
    switch("d", LIMITING_APP_IDS)
    return
}
e::
{
    SendInput ^{Up}
    return
}
!e:: 
{
    WinRestore, A
    SendEvent {LWin down}{Right down}{LWin up}{Right up}      
	centerMouse()
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
	global LIMITING_APP_IDS
    switch("f", LIMITING_APP_IDS)
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
	global LIMITING_APP_IDS
    switch("g", LIMITING_APP_IDS)
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
    WinRestore, A
    SendEvent {LWin down}{Left down}{LWin up}{Left up}      
	centerMouse()
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
	global LIMITING_APP_IDS
    switch("s", LIMITING_APP_IDS)
    return
}
!t::
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
}
!v::
{
	global LIMITING_APP_IDS
    switch("v", LIMITING_APP_IDS)
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
    SendInput !{Right}
    return
}
+x::
{
    SendInput !^{Right}
    return
}
!x:: 
{
	global LIMITING_APP_IDS
    switch("x", LIMITING_APP_IDS)
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
    SendInput !{Left}
    return
}
+z::
{
    SendInput !^{Left}
    return
}
!z:: 
{
	global LIMITING_APP_IDS
    switch("z", LIMITING_APP_IDS)
    return
}
!LEFT::
{
    SendInput #+{Left}
	return
}
!RIGHT::
{
    SendInput #+{Right}
	return
}

CapsLock::Suspend Off
~*CapsLock Up::Suspend On
