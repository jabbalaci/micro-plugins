VERSION = "0.1.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")

function file_exists(fname)
    local f = io.open(fname, "r")
    if f ~= nil then
        io.close(f)
        return true
    else
        return false
    end
end

function mypy(bp)
    --for determining the file type
    local buf = bp.Buf

	--defensive programming
	if buf:FileType() ~= "python" then
		micro.InfoBar():Error("not a Python file")
		return
	end

    if not file_exists("mypy.ini") then
        micro.InfoBar():Error("mypy.ini is missing")
        return
    end

    --arguments for terminal
    local jobArgs = { "mypy", "--config-file", "mypy.ini", buf.Path }

    --create buffer
    local tmpBuffer = buffer.NewBuffer("", "/tmp/micro_mypy")

    --open split
    local tmpBufferpane = bp:HSplitBuf(tmpBuffer)

    --open terminal
    tmpBufferpane:TermCmd(jobArgs)
end

function init()
    config.MakeCommand("mypy", mypy, config.NoComplete)
end
