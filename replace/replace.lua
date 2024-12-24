VERSION = "0.1.2"

-- written by Laszlo Szathmary (jabba.laci@gmail.com), 2023--2024
-- https://github.com/jabbalaci/micro-plugins

local micro = import("micro")
local config = import("micro/config")

--global variable, false by default
local IsOverwriteMode = false

function Replace(bp)
    IsOverwriteMode = not IsOverwriteMode
    local msg = ""
    if IsOverwriteMode then
        msg = "REPLACE"
    end
    micro.InfoBar():Message(msg)
end

function onEscape(bp)
    local msg = ""
    if IsOverwriteMode then
        msg = "REPLACE (Normal mode: Insert)"
    end
    micro.InfoBar():Message(msg)
    -- Return false to allow the ESC key to perform its normal function
    return false
end

function init()
    -- Bind the ESC key to our onEscape function
    config.TryBindKey("Escape", "lua:replace.onEscape", false)
end
