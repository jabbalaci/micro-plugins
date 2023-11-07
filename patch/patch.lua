VERSION = "0.1.0"

local config = import("micro/config")
local micro = import("micro")

function init()
    config.TryBindKey("CtrlUnderscore", "lua:comment.comment,CursorDown,StartOfTextToggle", true)

    -- config.Reload() -- not needed
    -- micro.InfoBar():Message("loaded") -- for debugging
end
