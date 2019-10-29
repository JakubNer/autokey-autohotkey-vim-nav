# autokey-autohotkey-vim-nav

Scripts for Windows AutoHotKey:

* allow vim like navigation across the OS.
* allow mouse scroll and navigation with keyboard (useful when using bad touchpads)
* allow quick recall of applications by title (see [app_switch_by_name.ahk](app_switch_by_name.ahk))
* allow quick binding of application windows to shortcut keys: quick window switching

*vim.ahk* file to be loaded by Windows AutoHotKey.

When this script is running CAPS LOCK is hijacked to enable the above.

## Key Bindings

All key bindings below require CAPS LOCK to be held down.

CAPS LOCK is no longer used as CAPS LOCK: a pretty useless key made useful, in my opinion.

### Application Window Binding

I tried various virtual windows managers over the years including bug.n, etc.  I find the mental task of dealing with virtual windows annoying.  I find binding running applications' windows to a shortcut key the simplest.

#### Preconfigured Recall

This approach has pre-configured keybindings that always work as soon as this script is loaded by AutoHotKey.

The following hotkeys are pre-configured:

`a,s,d,f,g,z,x,c,v,b`

To cycle/recall an application window hold CAPS LOCK + ALT then tap the corresponding key repeatedly until you land on the desired open app.

The specific applications recalled are controlled by the [app_switch_by_name.ahk](app_switch_by_name.ahk) script.

To reconfigure you must edit the [app_switch_by_name.ahk](app_switch_by_name.ahk) and restart the [vim.ahk](vim.ahk) script in your taskbar.

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several TITLES[".."] setters after the `;; COFIGURE APP TITLES TO RECALL ;;` comment.

The letter indexing each array element indicates which keyboard key (pressed together with `CAPS LOCK + ALT`) is bound to restore apps with provided title.

The string values of each array element is part of the application's window title to match on; each application with title matching one of these values is automatically part of the corresponding hotkey's recall.

Find this title using AutoHotKey's *Window Spy* application.

For example `TITLES["x"] := ["WhatsApp"]` means that the `x` hotkey is tied to any window with *WhatsApp* in the title: any *WhatsApp* instance.

Many different title substrings (different apps) can be added to a signle hotkey's recall.

#### Memorization to a Group

This approach allows binding of running any applications' windows to shortcut keys.

Unlike *Preconfigured Recall* above, these bindings reset when the system is reboot or when you reset them explicitly (below).

The following keys allow memorization of application windows for quick restore:

`1,2,3,4,5`

To memorize an application window hold CAPS LOCK then press SPACE and tap one of the above keys (while holding CAPS LOCK):

	`CAPS LOCK + SPACE, CAPS LOCK + 1` bind current app to group 1 (you can use 1 through 5)

You can memorize many applications to the same button and cycle through them.

To cycle/restore an application window hold CAPS LOCK + ALT tap the corresponding key repeatedly until you land on the desired open app:

	`CAPS LOCK + ALT + 1` to cycle through apps in group 1 (you can use 1 through 5)
	
	`CAPS LOCK + ALT + double tap 1` to show all apps in group 1 (you can use 1 through 5)

To reset a keybinding so that no applications are bound to it simply hold CAPS LOCK then pres TAB, then tap one of the above keys: 

	`CAPS LOCK + TAB, 1` to reset current app or all apps in group 1 (you can use 1 through 5)
	
Note that a *double tap* is within .3 second. 

**NOTE: Memorization Groups limit Preconfigured Recall** 

Once apps in a group are being cycled e.g. `CAPS LOCK + ALT + #` (or double tap #), the apps in *Preconfigured Recall* (see previous section) will be limited to apps in this group.  

There is a visual indication in the lower-right corner of the main monitor indicating the group selected.

To reset this limitation press `CAPS LOCK + ALT + 0` or `CAPS LOCK + ALT + SPACE`.

Please note that the first `CAPS LOCK + ALT + #` invocation does not cycle to the first groupped application: only subsequent uninterrupted key binding invocations do.  The first invocation selects the memorization group 

#### Preconfigured Apps to Run

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several `APP_TO_RUN_ON_KEY[".."] := "..."` statements after the `;; COFIGURE APP TO RUN ;;` comment.

These are the apps that can be started with pressing one of the following hotkeys after pressing CAPS + SPACE:

`a,s,d,f,g,z,x,c,v,b`

To run the app defined with `APP_TO_RUN_ON_KEY["a"]` press CAPS + SPACE the "a".

### Window Management Key bindings

I like to quickly snap Windows to the left-half of a wide screen, right-half of a wide screen, or to take up the full screen:

`CAPS + ALT + \`` make top 4 windows (in ALT TAB order) snap to screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.

**2x** `CAPS + ALT + \`` restore top 4 windows back from being snapped to corners: reverse `CAPS + ALT + r`.

`CAPS + ALT + q` snap window to left

`CAPS + ALT + e` snap window to right

`CAPS + ALT + w` snap window to top

**2x** `CAPS + ALT + w` maximize window

`CAPS + ALT + r` snap window to bottom

`CAPS + ALT + t` toggle task bar visibility on/off

### Mouse scrolling and Navigation

Unfortunately Windows laptops have varying qualities of touchpads, and scrolling with two fingers is annoying.  I like to move the cursor over a window with the right hand and use my left hand to scroll with the keyboard:

`CAPS+s` wheel down

`CAPS+a` wheel up

Mouse keys for navigating within browsers are very nice for most editors, map them:

`CAPS+z` browser back, alt left

`CAPS+x` browser forward, alt right

`CAPS+SHIFT+z` ctrl alt left // for some applications going back is this combo

`CAPS+SHIFT+x` ctrl alt right  // for some applications going forward is this combo

### VIM Editing Key Bindings

Laptop keyboards are notorious for different annoying layouts.  Vim navigation to the rescue:

`CAPS+h` left

`CAPS+j` right

`CAPS+k` up

`CAPS+l` down

`CAPS+g` ctrl home // start of document

`CAPS+SHIFT+g` ctrl end // end of document

`CAPS+b` page up

`CAPS+f` page down

`CAPS+e` ctrl up arrow // one line up, sort of not needed with mouse scrolling

`CAPS+y` ctrl down arrow // one line down

`CAPS+w` jump word, ctrl right // in most apps jumps a word

`CAPS+q` reverse jump word, ctrl left // in most apps reverse jumps worked

`CAPS+d` delete

`CAPS+0` start of line, home

`CAPS+-` end of line, end

`CAPS+i` 5 x up key

`CAPS+u` 5 x down key

The above work with SHIFT key down, for navigation while selecting.

## Repo Code Deprecation

I used to have code for Linux/Python AutoKey in this repo as well.

I find myself never switching to Linux anymore.  I've removed all the AutoKey code, especially since it's deprecated.

Commit [faea51a0c1c366816cc0957fb208b642f7ed27f9](https://github.com/JakubNer/autokey-autohotkey-vim-nav/commit/faea51a0c1c366816cc0957fb208b642f7ed27f9) is the last commit before removal of:

* Linux/Python AutoHotKey
* mouse scrolling helper scripts (AutoHotKey)
* xmouse (auto focus) PowerShell script
* desktop switching AutoHotKey scripts
* PowerShell script to make task preview windows bigger: never worked with Windows 10
