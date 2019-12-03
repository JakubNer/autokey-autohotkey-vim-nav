# autokey-autohotkey-vim-nav

Scripts for Windows AutoHotKey:

* allow vim like navigation across the OS.
* allow mouse scroll and navigation with keyboard (useful when using bad touchpads)
* allow quick recall of applications by title (see [app_switch_by_name.ahk](app_switch_by_name.ahk))
* allow quick binding of current ALT-TAB ordered windows to shortcut keys: quick window layout switching

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

Douple tapping CAPS LOCK + ALT and a corresponding key will recall the most recent desired open app in ALT-TAB order.

The specific applications recalled are controlled by the [app_switch_by_name.ahk](app_switch_by_name.ahk) script.

To reconfigure you must edit the [app_switch_by_name.ahk](app_switch_by_name.ahk) and restart the [vim.ahk](vim.ahk) script in your taskbar.

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several TITLES[".."] setters after the `;; COFIGURE APP TITLES TO RECALL ;;` comment.

The letter indexing each array element indicates which keyboard key (pressed together with `CAPS LOCK + ALT`) is bound to restore apps with provided title.

The string values of each array element is part of the application's window title to match on; each application with title matching one of these values is automatically part of the corresponding hotkey's recall.

Find this title using AutoHotKey's *Window Spy* application.

For example `TITLES["x"] := ["WhatsApp"]` means that the `x` hotkey is tied to any window with *WhatsApp* in the title: any *WhatsApp* instance.

Many different title substrings (different apps) can be added to a signle hotkey's recall.

#### Memorization to a Group

This approach allows binding of running applications' windows ALT-TAB order to shortcut keys.

This is useful for memorizing and recalling layout on multi-display setups.

The following keys allow memorization of application windows' ALT-TAB order for quick restore:

`1,2,3,4,5`

To memorize an order hold CAPS LOCK then press SPACE and tap one of the above keys (while holding CAPS LOCK):

	`CAPS LOCK + SPACE, CAPS LOCK + 1` bind current app to group 1 (you can use 1 through 5)

To restore an order hold CAPS LOCK + ALT tap the corresponding key:

	`CAPS LOCK + ALT + 1` to resore apps' ALT-TAB order as per group 1 (you can use 1 through 5)
	
#### Preconfigured Apps to Run

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several `APP_TO_RUN_ON_KEY[".."] := "..."` statements after the `;; COFIGURE APP TO RUN ;;` comment.

These are the apps that can be started with pressing one of the following hotkeys after pressing CAPS + SPACE:

`a,s,d,f,g,z,x,c,v,b`

To run the app defined with `APP_TO_RUN_ON_KEY["a"]` press CAPS + SPACE the "a".

Some apps do not start a new instance but just switch to a current instance.  To speed this up you can switch to the instance based on the window title.  Configure this with `APP_TITLE_TO_SWITCH_TO_ON_KEY[".."] := "..."` statements.

### Window Management Key bindings

I like to quickly snap Windows to the left-half of a wide screen, right-half of a wide screen, or to take up the full screen:

`CAPS + ALT + \`` make top 4 windows (in ALT TAB order) snap to screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.

**2x** `CAPS + ALT + \`` restore top 4 windows back from being snapped to corners: reverse `CAPS + ALT + \``.

`CAPS + ALT + q` snap window to left

**2x** `CAPS + ALT + q` snap window to top

`CAPS + ALT + e` snap window to right

**2x** `CAPS + ALT + e` snap window to bottom

`CAPS + ALT + w` snap window to top

**2x** `CAPS + ALT + w` maximize window

`CAPS + ALT + r` snap window to bottom

`CAPS + ALT + t` move window to next monitor clockwise

`CAPS + ALT + RIGHT` move window to next monitor clockwise

`CAPS + ALT + LEFT` move window to next monitor counter-clockwise

`CAPS + SHIFT + ALT + t` toggle task bar visibility on/off

### Mouse scrolling and Navigation

Unfortunately Windows laptops have varying qualities of touchpads, and scrolling with two fingers is annoying.  I like to move the cursor over a window with the right hand and use my left hand to scroll with the keyboard:

`CAPS+s` wheel down

`CAPS+a` wheel up

`CAPS+z` wheel left

`CAPS+x` wheel right

Mouse keys for navigating within browsers are very nice for most editors, map them:

`CAPS+c` browser back, alt left

`CAPS+v` browser forward, alt right

`CAPS+SHIFT+c` ctrl alt left // for some applications going back is this combo

`CAPS+SHIFT+v` ctrl alt right  // for some applications going forward is this combo

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
