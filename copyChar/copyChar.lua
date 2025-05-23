VERSION = "0.0.1"

local micro = import("micro")
local config = import("micro/config")

function init()
    config.MakeCommand("copycharabove", copyCharAbove, config.NoComplete)
    config.TryBindKey("Alt-u", "command:copycharabove", true)

    config.MakeCommand("copycharbelow", copyCharBelow, config.NoComplete)
    config.TryBindKey("Alt-d", "command:copycharbelow", true)
end

function copyCharAbove(bp)
    -- micro.InfoBar():Message("")
    local c = bp.Cursor
    local cx, cy = c.Loc.X, c.Loc.Y
    if cy == 0 then
        -- micro.InfoBar():Message("No line above")
        return
    end

    local lineAbove = bp.Buf:Line(cy - 1)
    local charAbove = lineAbove:sub(c.Loc.X + 1, c.Loc.X + 1)
    if charAbove == "" then
        -- micro.InfoBar():Message("No char above")
        return
    end
    -- c.Loc is a pointer to a Loc object, but the Insert method expects
    -- a Loc value, not a pointer. You need to dereference it.
    bp.Buf:Insert(-c.Loc, charAbove)
end

function copyCharBelow(bp)
    -- micro.InfoBar():Message("")
    local c = bp.Cursor
    local cx, cy = c.Loc.X, c.Loc.Y
    local numLines = bp.Buf:LinesNum()
    if cy >= numLines - 1 then
        -- micro.InfoBar():Message("No line below")
        return
    end
    local lineBelow = bp.Buf:Line(cy + 1)
    local charBelow = lineBelow:sub(c.Loc.X + 1, c.Loc.X + 1)
    if charBelow == "" then
        -- micro.InfoBar():Message("No char below")
        return
    end
    -- c.Loc is a pointer to a Loc object, but the Insert method expects
    -- a Loc value, not a pointer. You need to dereference it.
    bp.Buf:Insert(-c.Loc, charBelow)
end
