VERSION = "0.1.0"

local micro = import("micro")
local config = import("micro/config")
local filepath = import("path/filepath")

function init()
    config.MakeCommand("sp", showPath, config.NoComplete)
    config.MakeCommand("cpc", cpc, config.NoComplete)
end

-- just show the absolute path of the current file
-- it doesn't copy the path to the clipboard
function showPath(bp)
    local absPath = filepath.Abs(bp.Buf.Path)
    micro.InfoBar():Message(absPath)
end

-- copy the absolute path of the current file to the clipboard
function cpc(bp)
    local buf = bp.Buf
    local absPath = filepath.Abs(buf.Path)

    local result = ctc(absPath)
    if result == 0 then
        micro.InfoBar():Message(string.format("%s was copied to the clipboard", absPath))
    else
        micro.InfoBar():Error("copy path to clipboard failed")
    end
end

-- copy text to clipboard
-- Returns 0 (exit code) if everything was OK, otherwise returns non-zero value
function ctc(text)
    local cmd = string.format("echo '%s' | xsel -b 2>/dev/null", text)
    return os.execute(cmd)
end
