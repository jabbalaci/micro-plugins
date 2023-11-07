# patch

micro has a built-in plugin called "comment". 
When you launch micro, this plugin writes
the following line in your `bindings.json:`

    "CtrlUnderscore": "lua:comment.comment",

## Problem

Instead of this behavior, I wanted this:

    "CtrlUnderscore": "lua:comment.comment,CursorDown,StartOfTextToggle",

That is, comment the line and move the cursor one line down. This way, commenting several lines is much easier.

However, these changes are always overwritten
by the plugin "comment". When you start micro,
the plugin overwrites this binding.

## Solution

Custom plugins are loaded after the built-in ones.
Thus, simply make a plugin that overwrites this
binding with the value you want.

The whole plugin is just a few lines:

```lua
local config = import("micro/config")

function init()
    config.TryBindKey("CtrlUnderscore", "lua:comment.comment,CursorDown,StartOfTextToggle", true)
end
```

This is actually a patch that overwrites (corrects)
the value that is written in `bindings.json` by
the built-in plugin "comment".
