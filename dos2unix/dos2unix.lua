VERSION = "0.1.0"

local micro = import("micro")
local config = import("micro/config")

function reformat(bp, cmd)
    bp.Buf:SetOption("fileformat", "unix")
    bp:Save()
    bp.Buf:ReOpen() -- not sure if it's necessary
end

function dos(bp)
    cmd = string.format("dos2unix '%s'", bp.Buf.Path)
    reformat(bp, cmd)
end

function init()
    config.MakeCommand("dos", dos, config.NoComplete)
    config.MakeCommand("unix", dos, config.NoComplete)
end
