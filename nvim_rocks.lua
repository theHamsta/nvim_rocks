--
-- nvim_rocks.lua
-- Copyright (C) 2020 Stephan Seitz <stephan.seitz@fau.de>
--
-- Distributed under terms of the GPLv3 license.
--

local nvim_rocks = {}

-- from: https://stackoverflow.com/questions/6380820/get-containing-path-of-lua-file#23535333
local function script_path()
    local str = debug.getinfo(2, "S").source:sub(2)
    return str:match("(.*/)")
end

local function plugin_path()
    return script_path() .. "../../.."
end

local function has_value(tab, val)
    for _, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end

local rock_print = function(text)
    print("🤘" .. text)
end

local print_list = function(list)
    for _, line in ipairs(list) do
        print(line)
    end
end

nvim_rocks.install = function(name)
    rock_print('Trying to install "' .. name .. '"')
    local result = vim.fn.systemlist("source " .. plugin_path() .. "/bin/activate && luarocks install " .. name)
    print_list(result)

    -- copy shared objects to lua path that neovim finds them
    vim.fn.systemlist("ln -s " .. plugin_path() .. "/lib/lua/5.1/*.so " .. plugin_path() .. "/lua")
end

nvim_rocks.remove = function(name)
    rock_print('Trying to remove "' .. name .. '"')
    local result = vim.fn.systemlist("source " .. plugin_path() .. "/bin/activate && luarocks remove " .. name)
    print_list(result)

    -- Update links to shared objects
    vim.fn.systemlist("rm " .. plugin_path() .. "/lua/*.so")
    vim.fn.systemlist("ln -s " .. plugin_path() .. "/lib/lua/5.1/*.so " .. plugin_path() .. "/lua")
end

nvim_rocks.list = function(simple, outdated)
    local cmd_output
    if outdated then
        cmd_output =
            vim.fn.systemlist("source " .. plugin_path() .. "/bin/activate && luarocks list --porcelain --outdated")
    else
        cmd_output = vim.fn.systemlist("source " .. plugin_path() .. "/bin/activate && luarocks list --porcelain")
    end
    local result = {}
    for _, line in ipairs(cmd_output) do
        for package, version, status, install_path in string.gmatch(line, "([^\t]+)\t([^\t]+)\t([^\t]+)\t([^\t]+)") do
            if version then
                if simple then
                    table.insert(result, package)
                else
                    table.insert(
                        result,
                        {
                            package = package,
                            version = version,
                            status = status,
                            install_path = install_path
                        }
                    )
                end
            end
        end
    end
    return result
end

nvim_rocks.ensure_installed = function(packages)
    if type(packages) == "string" then
        packages = {packages}
    end

    local installed = nvim_rocks.list(true)

    for _, package in ipairs(packages) do
        if not has_value(installed, package) then
            nvim_rocks.install(package)
        end
    end
end

return nvim_rocks
