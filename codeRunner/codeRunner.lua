VERSION = "0.1.0"

local micro = import("micro")
local config = import("micro/config")
local buffer = import("micro/buffer")
local shell = import("micro/shell")

local function SplitFilename(strFilename)
    -- Returns the Path, Filename, and Extension as 3 values
    return string.match(strFilename, "(.-)([^/]-([^/%.]+))$")
end

function codeRunner(bp)
    --for determining the file type
    local buf = bp.Buf

    --arguments for terminal
    local jobArgs = {}

    if buf:FileType() == "python" then
        jobArgs = { "python3", bp.Buf.Path }
    elseif buf:FileType() == "go" then
        jobArgs = { "go", "run", bp.Buf.Path }
    elseif buf:FileType() == "csharp" then
        jobArgs = { "dotnet", "run" }
    elseif buf:FileType() == "lua" then
        jobArgs = { "lua", bp.Buf.Path }
    elseif buf:FileType() == "shell" then
        jobArgs = { "bash", bp.Buf.Path }
    elseif buf:FileType() == "c" then
        out, err = shell.RunCommand("gcc " .. buf.Path)
        if err ~= nil then
            micro.InfoBar():Error(out)
            return
        end
        jobArgs = { "./a.out" }
    elseif buf:FileType() == "java" then
        out, err = shell.RunCommand("javac " .. buf.Path)
        if err ~= nil then
            micro.InfoBar():Error(out)
            return
        end
        local path, fname, extension = SplitFilename(buf.Path)
        local fnameWithoutExt = fname:match("(.+)%..+")
        jobArgs = { "java", fnameWithoutExt }
    else
        micro.InfoBar():Error("unknown filetype")
        return
    end

    --create buffer
    local tmpBuffer = buffer.NewBuffer("", "/tmp/micro_codeRunner")

    --open split
    local tmpBufferpane = bp:HSplitBuf(tmpBuffer)

    --open terminal
    tmpBufferpane:TermCmd(jobArgs)
end

function init()
    config.TryBindKey("Ctrl-r", "lua:codeRunner.codeRunner", true)
end
