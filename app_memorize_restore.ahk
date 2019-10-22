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
APP_MEM_GROUP_COUNT := {}

ensureAppMemGroupCount(which, index) {
  global APP_MEM_GROUP_COUNT
  if (! APP_MEM_GROUP_COUNT.HasKey(%which%_%index%)) {
    APP_MEM_GROUP_COUNT[%which%_%index%] := 0
  }
}

incrementAppMemGroupCount(which, index) {
	global APP_MEM_GROUP_COUNT
	APP_MEM_GROUP_COUNT[%which%_%index%] := APP_MEM_GROUP_COUNT[%which%_%index%] + 1
}

resetAppMemGroupCount(which, index) {
	global APP_MEM_GROUP_COUNT
	APP_MEM_GROUP_COUNT.Delete(%which%_%index%)
}

memorize(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT

  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  }
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)

  WinGet, APP_MEM_CURRENT_APP, ID, A
  Winget,APP_TITLE,ProcessName,A
  GroupAdd, memorize_app_%which%_%index%, ahk_id %APP_MEM_CURRENT_APP%
  incrementAppMemGroupCount(which, index)
  return
}

reset_memory(which) {
  global APP_MEM_GROUP_INDICES
  if (! APP_MEM_GROUP_INDICES.HasKey(which)) {
    APP_MEM_GROUP_INDICES[which] := 1
  } else {
	index := APP_MEM_GROUP_INDICES[which]
	resetAppMemGroupCount(which, index)
    APP_MEM_GROUP_INDICES[which] := APP_MEM_GROUP_INDICES[which] + 1
  }
}

restore(which)
{
  global APP_MEM_GROUP_INDICES
  global APP_MEM_GROUP_COUNT
  index := APP_MEM_GROUP_INDICES[which]
  ensureAppMemGroupCount(which, index)
  count := APP_MEM_GROUP_COUNT[%which%_%index%]
  while count > 0 {
    GroupActivate, memorize_app_%which%_%index%, R
	count := count - 1
  }
  GroupActivate, memorize_app_%which%_%index%, R
  return
}
