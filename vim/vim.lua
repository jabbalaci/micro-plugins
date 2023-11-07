VERSION = "0.1.0"

local config = import("micro/config")
local shell = import("micro/shell")
local filepath = import("path/filepath")
local micro = import("micro")

function init()
    config.MakeCommand("vim", openWithVim, config.NoComplete)
end

local VIM = "nvim"

function openWithVim(bp)
    -- if it's an empty buffer (that has never been saved)
    if bp.Buf.Path:len() == 0 then
        micro.InfoBar():Error("save it first")
        return
    end
    -- else
    local absPath = filepath.Abs(bp.Buf.Path)
    local c = bp.Buf:GetActiveCursor()
    local line = c.Loc.Y + 1 -- in vim, jump to the same line

    local cmd = string.format("%s +%d %s", VIM, line, absPath)

    bp:Save() -- save first
    shell.RunInteractiveShell(cmd, false, false) -- launch vim
end
