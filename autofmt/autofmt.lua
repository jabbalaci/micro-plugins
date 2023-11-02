VERSION = "0.1.2"

local config = import("micro/config")

function init()
    config.MakeCommand("fmt", onSave, config.NoComplete)
end

function onSave(bp)
    local cmd = ""

    local ft = bp.Buf:FileType()
    if ft == "python" then
        cmd = "black --line-length 100 " .. bp.Buf.Path
        reformat(bp, cmd)
        cmd = "isort  " .. bp.Buf.Path
        reformat(bp, cmd)
    elseif ft == "lua" then
        cmd = "stylua --indent-type Spaces --indent-width 4 " .. bp.Buf.Path
        reformat(bp, cmd)
    elseif ft == "go" then
        cmd = "go fmt " .. bp.Buf.Path
        reformat(bp, cmd)
    elseif ft == "c" then
        cmd = "clang-format --style=Microsoft -i " .. bp.Buf.Path
        -- cmd = "clang-format --style=Webkit -i " .. bp.Buf.Path
        reformat(bp, cmd)
    end
end

function reformat(bp, cmd)
    bp:Save()
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    bp.Buf:ReOpen()
end
