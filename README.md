# autokey-autohotkey-vim-nav
Scripts for Linux's autokey and Windows autohotkey to allow vim like navigation in all programs.

Python files are to be loaded by Linux autokey (https://code.google.com/archive/p/autokey/).

*vim.ahk* file to be loaded by Windows AutoHotKey.  *mouse.ahk* has the middle button scrolling code if desired.

I like to map CAPS LOCK to HYPER in Linux and LCTRL in Windows hence the mappings.  To modify Windows registry use RandyRants Sharpkeys key mapper.

For Linux add `xmodmap $HOME/.xmodmap` on startup and have your .xmodmap file with:

```
keycode 66 = Hyper_L
```

(or use *xev* to find keycode of key to map to HYPER).
