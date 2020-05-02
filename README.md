# autokey-autohotkey-vim-nav

Scripts for Windows AutoHotKey:

* allow vim like navigation across the OS.
* allow mouse scroll and navigation with keyboard (useful when using bad touchpads)
* allow quick recall of applications by title (see [app_switch_by_name.ahk](app_switch_by_name.ahk))
* allow quick binding of current ALT-TAB ordered windows to shortcut keys: quick window layout switching

*vim.ahk* file to be loaded by Windows AutoHotKey.

When this script is running F20 is used as a modifier.

>
> F20 is not on any normal keyboard.
>
> I use RandyRants SharpKeys to map RIGHT-ALT to F20 to toggle modifier.
>

## Key Bindings

All key bindings below require F20 to be held down.

### Application Window Binding

I tried various virtual windows managers over the years including bug.n, etc.  I find the mental task of dealing with virtual windows annoying.  I find binding running applications' windows to a shortcut key the simplest.

#### Preconfigured Recall

This approach has pre-configured keybindings that always work as soon as this script is loaded by AutoHotKey.

The following hotkeys are pre-configured:

`a,s,d,f,g,z,x,c,v,b`

To cycle/recall an application window hold F20 + ALT then tap the corresponding key.  If the keybind currently has multiple associated applications open, a list view is presented in ALT-TAB order.  The list view has an indicator of which screen the application is on for easy picking.

Douple tapping F20 + ALT and a corresponding key will recall the most recent desired open app in ALT-TAB order.

The specific applications recalled are controlled by the [app_switch_by_name.ahk](app_switch_by_name.ahk) script.

To reconfigure you must edit the [app_switch_by_name.ahk](app_switch_by_name.ahk) and restart the [vim.ahk](vim.ahk) script in your taskbar.

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several TITLES[".."] setters after the `;; COFIGURE APP TITLES TO RECALL ;;` comment.

The letter indexing each array element indicates which keyboard key (pressed together with `F20 + ALT`) is bound to restore apps with provided title.

The string values of each array element is part of the application's window title to match on; each application with title matching one of these values is automatically part of the corresponding hotkey's recall.

Find this title using AutoHotKey's *Window Spy* application.

For example `TITLES["x"] := ["WhatsApp"]` means that the `x` hotkey is tied to any window with *WhatsApp* in the title: any *WhatsApp* instance.

Many different title substrings (different apps) can be added to a signle hotkey's recall.

#### Memorization to a Group

This approach allows binding of running applications' windows ALT-TAB order to shortcut keys.

This is useful for memorizing and recalling layout on multi-display setups.

The following keys allow memorization of application windows' ALT-TAB order for quick restore:

`1,2,3,4,5`

To memorize an order hold F20 then press SPACE and tap one of the above keys (while holding F20):

	`F20 + SPACE, F20 + 1` bind current app to group 1 (you can use 1 through 5)

To restore an order hold F20 + ALT tap the corresponding key:

	`F20 + ALT + 1` to resore apps' ALT-TAB order as per group 1 (you can use 1 through 5)
	
#### Preconfigured Apps to Run

Looking at the [app_switch_by_name.ahk](app_switch_by_name.ahk) script you will find several `APP_TO_RUN_ON_KEY[".."] := "..."` statements after the `;; COFIGURE APP TO RUN ;;` comment.

These are the apps that can be started with pressing one of the following hotkeys after pressing F20 + SPACE:

`a,s,d,f,g,z,x,c,v,b`

To run the app defined with `APP_TO_RUN_ON_KEY["a"]` press F20 + SPACE the "a".

Some apps do not start a new instance but just switch to a current instance.  To speed this up you can switch to the instance based on the window title.  Configure this with `APP_TITLE_TO_SWITCH_TO_ON_KEY[".."] := "..."` statements.

If you want to add your own keybindings and not affect the git repo, add your binding overrides to [overrides.ahk](overrides.ahk).  Notice that [overrides.ahk](overrides.ahk) is `#Include`'d after the above definitions in [app_switch_by_name.ahk](app_switch_by_name.ahk), and it's `.gitignore`'d.

### Window Management Key bindings

I like to quickly snap Windows to the left-half of a wide screen, right-half of a wide screen, or to take up the full screen:

`F20 + ALT + \`` make top 4 windows (in ALT TAB order) snap to screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.

**2x** `F20 + ALT + \`` restore top 4 windows back from being snapped to corners: reverse `F20 + ALT + \``.

`F20 + ALT + q` snap window to left

**2x** `F20 + ALT + q` snap window to top

`F20 + ALT + e` snap window to right

**2x** `F20 + ALT + e` snap window to bottom

`F20 + ALT + w` snap window to top

**2x** `F20 + ALT + w` maximize window

`F20 + ALT + r` snap window to bottom

`F20 + ALT + t` move window to next monitor clockwise

`F20 + ALT + RIGHT` move window to next monitor clockwise

`F20 + ALT + LEFT` move window to next monitor counter-clockwise

`F20 + SHIFT + ALT + t` toggle task bar visibility on/off

### Mouse scrolling and Navigation

Unfortunately Windows laptops have varying qualities of touchpads, and scrolling with two fingers is annoying.  I like to move the cursor over a window with the right hand and use my left hand to scroll with the keyboard:

`F20+s` wheel down

`F20+a` wheel up

`F20+z` wheel left

`F20+x` wheel right

Mouse keys for navigating within browsers are very nice for most editors, map them:

`F20+c` browser back, alt left

`F20+v` browser forward, alt right

`F20+SHIFT+c` ctrl alt left // for some applications going back is this combo

`F20+SHIFT+v` ctrl alt right  // for some applications going forward is this combo

### VIM Editing Key Bindings

Laptop keyboards are notorious for different annoying layouts.  Vim navigation to the rescue:

`F20+h` left

`F20+j` right

`F20+k` up

`F20+l` down

`F20+g` ctrl home // start of document

`F20+SHIFT+g` ctrl end // end of document

`F20+b` page up

`F20+f` page down

`F20+e` ctrl up arrow // one line up, sort of not needed with mouse scrolling

`F20+y` ctrl down arrow // one line down

`F20+w` jump word, ctrl right // in most apps jumps a word

`F20+q` reverse jump word, ctrl left // in most apps reverse jumps worked

`F20+d` delete

`F20+0` start of line, home

`F20+-` end of line, end

`F20+i` 5 x up key

`F20+u` 5 x down key

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
