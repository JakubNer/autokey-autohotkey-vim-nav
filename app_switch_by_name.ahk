APP_MEM_OUTPUT_VAR := Object()

; using *AHL Window Spy* get a portion of the `ahk_class`
;
; sample use:
;   q::switch("c")
;

SetTitleMatchMode, 2 

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TITLES TO GROUPS ;;

GroupAdd, switch_a, ahk_exe ConEmu64.exe
GroupAdd, switch_a, Alacritty
GroupAdd, switch_a, ahk_exe mintty.exe
GroupAdd, switch_a, ahk_exe bash.exe
GroupAdd, switch_s, Notepad++
GroupAdd, switch_s, ahk_exe miMind.exe
GroupAdd, switch_s, Freeplane
GroupAdd, switch_d, Visual Studio Code
GroupAdd, switch_f, Sourcetree
GroupAdd, switch_f, ahk_exe webdesigner.exe
GroupAdd, switch_f, ahk_exe Postman.exe
GroupAdd, switch_f, ahk_exe VirtualBox.exe
GroupAdd, switch_g, Snip & Sketch
GroupAdd, switch_g, ahk_exe PaintDotNet.exe
GroupAdd, switch_g, Astah
GroupAdd, switch_z, Gmail
GroupAdd, switch_z, Google Calendar
GroupAdd, switch_x, MightyText
GroupAdd, switch_x, WhatsApp
GroupAdd, switch_x, Viber
GroupAdd, switch_x, Slack
GroupAdd, switch_x, Messenger
GroupAdd, switch_x, Discord
GroupAdd, switch_c, Chrome
GroupAdd, switch_c, ahk_exe firefox.exe
GroupAdd, switch_v, Chromium
; GroupAdd, switch_b, ??

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


switch(which)
{
  GroupActivate, switch_%which%, R
  return
}
