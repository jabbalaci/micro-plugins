VERSION = "0.1.0"

-- from https://github.com/zyedidia/micro/issues/2996

local micro = import("micro")

function closeOthers(bp)
    local others = {}
    local iter = micro.CurTab().Panes()
    for _, p in iter do
        if p:ID() ~= bp:ID() then
            table.insert(others, p)
        end
    end
    for _, p in pairs(others) do
        p:Quit()
    end
end
