# autokey-autohotkey-vim-nav

Scripts for Windows AutoHotKey:

* allow vim like navigation across the OS.
* allow mouse scroll and navigation with keyboard (useful when using bad touchpads)
* allow quick binding of application windows to shortcut keys: quick window switching

*vim.ahk* file to be loaded by Windows AutoHotKey.

When this script is running CAPS LOCK is hijacked to enable the above.

## Key Bindings

All key bindings below require CAPS LOCK to be held down.

CAPS LOCK is no longer used as CAPS LOCK: a pretty useless key made useful, in my opinion.

### Application Window Binding

I tried various virtual windows managers over the years including bug.n, etc.  I find the mental task of dealing with virtual windows annoying.  I find binding running applications' windows to a shortcut key the simplest.

Even after a reboot, rebinding the applications is quick and easy for me.

The following keys allow memorization of application windows for quick recall:

`1,2,3,4,5,a,s,d,f,g,z,x,c,v,b,u,i,o,j,k,l`

To memorize an application window hold CAPS LOCK then press SPACE, then hold SHIFT while single, double, or triple tapping one of the above keys.

To recall an application windows  hold CAPS LOCK then press SPACE, then single, double, or triple tap the corresponding key.

#### Example

I organize my task bar icons in the order that I always map some common applications, then re-mapping on restart is quick and painless (I also rarely restart):

`CAPS+SPACE,CAPS+a` ConEmu

`CAPS+SPACE,CAPS+s` Notepad++

`CAPS+SPACE,CAPS+d` IntelliJ IDEA

**2x** `CAPS+SPACE,CAPS+d` Atom

`CAPS+SPACE,CAPS+f` IntelliJ IDEA REPL Window

`CAPS+SPACE,CAPS+z` Outlook

`CAPS+SPACE,CAPS+x` Slack

**2x** `CAPS+SPACE,CAPSE+x` WhatsApp

... etc.

### Window Management Key bindings

I like to quickly snap Windows to the left-half of a wide screen, right-half of a wide screen, or to take up the full screen:

`CAPS+SPACE,CAPS+r` make top 4 windows (in ALT TAB order) snap to screen corners in order top left, top right, bottom left, bottom right, preserving ALT TAB order.

**2x** `CAPS+SPACE,CAPSE+r` restore top 4 windows back from being snapped to corners: reverse `CAPS+SPACE,CAPS+r`.

`CAPS+SPACE,CAPS+q` window to left

`CAPS+SPACE,CAPS+w` window full size

`CAPS+SPACE,CAPS+e` window to right

`CAPS+SPACE,CAPS+t` toggle task bar visibility on/off

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
