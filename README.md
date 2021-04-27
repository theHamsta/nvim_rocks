# nvim_rocks 🤘

Install [luarock](https://luarocks.org/) packages for Neovim's built-in Lua interpreter.

## Important Note

Functionality of this plugin has been added to https://github.com/wbthomason/packer.nvim. Please use packer.nvim for a maintained version for luarock dependencies!

## Installation

I use [hererock](https://github.com/luarocks/hererocks) to set up a luajit local enviroment.
Adapt if you use a different pip binary or you want to use a different luarocks version (latest was not working for me).

```vim
    Plug 'theHamsta/nvim_rocks', {'do': 'pip3 install --user hererocks && python3 -mhererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
```

I am currently using the latest nightly of Neovim.

## Usage

```lua
local nvim_rocks = require'nvim_rocks'

-- Force installation of rock
nvim_rocks.install('30log')

-- Ensure that certain rocks are installed
nvim_rocks.ensure_installed('lua-cjson')
nvim_rocks.ensure_installed({'lua-cjson', 'stdlib'})
nvim_rocks.ensure_installed('fun') -- nice functional programming for LuaJIT!

-- require stuff from binary rock
local cjson = require "cjson"
local cjson2 = cjson.new()
local cjson_safe = require "cjson.safe"

print(vim.inspect(cjson_safe))

-- List installed rocks with version numbers
print(vim.inspect(nvim_rocks.list()))

-- List installed rocks as strings
local simple = true
print(vim.inspect(nvim_rocks.list(simple)))

-- Remove rock
nvim_rocks.remove('lua-cjson')
```

There's also three commands for install/uninstall and listing the installed packages:

 * `NvimRocksInstall <package>`
 * `NvimRocksRemove <package>`
 * `NvimRocksList`

## Alternatives

If you want to install just pure Lua packages you might also install them manually:

```vim
    Plug 'Yonaba/30log', {'do': 'mkdir -p lua && cp *.lua lua'}
    Plug 'lua-stdlib/lua-stdlib', {'do': 'cp -r lib lua'}
```

Now https://github.com/wbthomason/packer.nvim has luarocks support
