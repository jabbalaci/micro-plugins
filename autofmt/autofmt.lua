VERSION = "0.1.6"

--[[
    clang-format's preset coding styles:
    LLVM, GNU, Google, Chromium, Microsoft, Mozilla, WebKit
]]

local config = import("micro/config")

function init()
    config.MakeCommand("fmt", onSave, config.NoComplete)
end

function reformat(bp, cmd)
    bp:Save()
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    bp.Buf:ReOpen()
end

function execute(bp, cmd)
    bp:Save()
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
end

function onSave(bp)
    local cmd = ""

    local ft = bp.Buf:FileType()
    if ft == "python" then
        -- cmd = string.format("black --line-length 100 '%s'", bp.Buf.Path)
        cmd = string.format("ruff check --fix --select I '%s'", bp.Buf.Path)
        reformat(bp, cmd)
        -- cmd = string.format("isort '%s'", bp.Buf.Path)
        cmd = string.format("ruff format '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "lua" then
        cmd = string.format("stylua --indent-type Spaces --indent-width 4 '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "d" then
        cmd = string.format("dfmt -i '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "go" then
        cmd = string.format("go fmt '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "c" then
        cmd = string.format("clang-format --style=Microsoft -i '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "csharp" then
        cmd = string.format("clang-format --style=Microsoft -i '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "java" then
        cmd = string.format("clang-format --style=Microsoft -i '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "json" then
        cmd = string.format("clang-format --style=Microsoft -i '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "gleam" then
        cmd = string.format("gleam format '%s'", bp.Buf.Path)
        reformat(bp, cmd)
    elseif ft == "pascal" then
        -- find more info here: https://github.com/jabbalaci/FreePascalStuff
        local formatter_cfg = "/home/jabba/Dropbox/pascal/FreePascalStuff/jcf-pascal-format/jabba.cfg"
        -- call pascal-format
        cmd = string.format("pascal-format -config='%s' '%s'", formatter_cfg, bp.Buf.Path)
        reformat(bp, cmd)
    end
end
