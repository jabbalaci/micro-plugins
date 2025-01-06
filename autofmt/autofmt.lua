VERSION = "0.1.5"

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
        local temp_file = string.format("%s.hjg6343.tmp", bp.Buf.Path)
        -- find these two (v) files below here: https://github.com/jabbalaci/FreePascalStuff
        local ptop_cfg = "/home/jabba/Dropbox/pascal/FreePascalStuff/ptop/config.cfg"
        local post_correction = "/home/jabba/Dropbox/pascal/FreePascalStuff/ptop/post_correction.py"
        -- call ptop
        cmd = string.format("ptop -l 100 -c '%s' '%s' '%s'", ptop_cfg, bp.Buf.Path, temp_file)
        execute(bp, cmd)
        -- rename temp file to current file
        cmd = string.format("mv '%s' '%s'", temp_file, bp.Buf.Path)
        execute(bp, cmd)
        bp.Buf:ReOpen()
        -- call post-correction script to fix some issues of ptop
        cmd = string.format("%s '%s' '%s'", post_correction, bp.Buf.Path, temp_file)
        execute(bp, cmd)
        -- rename temp file to current file
        cmd = string.format("mv '%s' '%s'", temp_file, bp.Buf.Path)
        execute(bp, cmd)
        -- reload current buffer
        bp.Buf:ReOpen()
    end
end
