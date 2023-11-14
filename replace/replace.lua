VERSION = "0.1.1"

-- written by Laszlo Szathmary (jabba.laci@gmail.com), 2023
-- https://github.com/jabbalaci/micro-plugins

local micro = import("micro")

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
