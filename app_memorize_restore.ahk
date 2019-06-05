APP_MEM_OUTPUT_VAR := Object()

; - memorize current app ID to group by some 'which' key
; - toggle through apps in group by some 'which' key
; - reset group for 'which' key
;
; sample use:
;   +!q::memorize("a")
;   !q::restore("a")
;   ^+!q::reset_memory("a")
;

APP_MEM_GROUP_INDICES := {}

memorize(which)
{
  global APP_MEM_GROUP_INDICES

  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  }
  index := APP_MEM_GROUP_INDICES[which]

  WinGet, APP_MEM_CURRENT_APP, ID, A
  Winget,APP_TITLE,ProcessName,A
  GroupAdd, memorize_app_%which%_%index%, ahk_id %APP_MEM_CURRENT_APP%
  return
}

reset_memory(which) {
  global APP_MEM_GROUP_INDICES
  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  } else {
    APP_MEM_GROUP_INDICES[which] := APP_MEM_GROUP_INDICES[which] + 1
  }
}

restore(which)
{
  global APP_MEM_GROUP_INDICES
  index := APP_MEM_GROUP_INDICES[which]
  GroupActivate, memorize_app_%which%_%index%, R
  return
}
