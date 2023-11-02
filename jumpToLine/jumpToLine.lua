VERSION = "0.1.0"

local micro = import("micro")
local config = import("micro/config")

local function jump(bp, args)
    --defensive programming
    if #args <= 0 then
        micro.InfoBar():Error("Not enough arguments")
        return
    end

    local buf = bp.Buf

    local input = args[1]
    local linesNum = buf:LinesNum()
    local line
    if input:sub(-1, -1) == "%" then
        local percent = tonumber(input:sub(1, -2))
        if not percent then
            micro.InfoBar():Error("wrong value")
            return
        end
        line = math.floor((percent * linesNum) / 100 + 0.5) -- rounding
    else
        line = tonumber(input)
        if not line then
            micro.InfoBar():Error("wrong value")
            return
        end
    end

    if line < 1 then -- negative indexing, -1 is the last line
        line = linesNum + line + 1
        if line < 1 then -- if it's still negative
            line = 1
        end
    end
    if line > linesNum then
        line = linesNum
    end

    local c = bp.Buf:GetActiveCursor()
    c.Loc.Y = line - 1
    bp:Relocate()

    -- micro.InfoBar():Message(string.format("Value: %s, no. of lines: %d, line: %d", input, linesNum, line)) -- for testing
end

function init()
    config.MakeCommand("jump", jump, config.NoComplete)
end
