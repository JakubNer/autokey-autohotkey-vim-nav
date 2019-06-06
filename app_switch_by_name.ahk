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
GroupAdd, switch_s, Notepad++
GroupAdd, switch_d, Visual Studio Code
GroupAdd, switch_f, Sourcetree
; GroupAdd, switch_g, ??
GroupAdd, switch_z, Gmail
GroupAdd, switch_z, Google Calendar
GroupAdd, switch_x, MightyText
GroupAdd, switch_x, WhatsApp
GroupAdd, switch_x, Viber
GroupAdd, switch_x, Slack
GroupAdd, switch_x, Messenger
GroupAdd, switch_x, Discord
GroupAdd, switch_c, Chrome
GroupAdd, switch_v, Chromium
; GroupAdd, switch_b, ??

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


switch(which)
{
  GroupActivate, switch_%which%, R
  return
}
