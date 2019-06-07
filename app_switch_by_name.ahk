APP_MEM_OUTPUT_VAR := Object()

; using *AHL Window Spy* get a portion of the `ahk_class`
;
; sample use:
;   q::switch("c")
;
; for run:
;   q::run("c")

SetTitleMatchMode, 2 



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TITLES TO GROUPS ;;

GroupAdd, switch_a, Alacritty
GroupAdd, switch_a, MINGW64
GroupAdd, switch_a, Docker Quickstart Terminal
GroupAdd, switch_s, Notepad++
GroupAdd, switch_s, miMind
GroupAdd, switch_s, Freeplane
GroupAdd, switch_d, Visual Studio Code
GroupAdd, switch_f, Sourcetree
GroupAdd, switch_f, Google Web Designer
GroupAdd, switch_f, Postman
GroupAdd, switch_f, VirtualBox 
GroupAdd, switch_g, Snip & Sketch
GroupAdd, switch_g, ahk_exe PaintDotNet.exe
GroupAdd, switch_g, Astah
GroupAdd, switch_g, Pencil
GroupAdd, switch_z, Gmail
GroupAdd, switch_z, Google Calendar
GroupAdd, switch_x, MightyText
GroupAdd, switch_x, WhatsApp
GroupAdd, switch_x, Viber
GroupAdd, switch_x, Slack
GroupAdd, switch_x, Messenger
GroupAdd, switch_x, Discord
GroupAdd, switch_c, Chrome
GroupAdd, switch_c, Opera
GroupAdd, switch_c, Firefox
GroupAdd, switch_v, Chromium
; GroupAdd, switch_b, ??



;;;;;;;;;;;;;;;;;;;;;;;;;
;; COFIGURE APP TO RUN ;;

APP_TO_RUN_ON_KEY := {}

APP_TO_RUN_ON_KEY["a"] := "C:\Program Files\Alacritty\alacritty.exe"



switch(which)
{
  GroupActivate, switch_%which%, R
  return
}

run(which) 
{
  global APP_TO_RUN_ON_KEY
  app := APP_TO_RUN_ON_KEY[which]
  Run, %app%
}