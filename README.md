# nvim_rocks 🤘

Install [luarock](https://luarocks.org/) packages for Neovim's built-in Lua interpreter.

## Installation

We use [hererock](https://github.com/luarocks/hererocks) to set up a luajit local enviroment.
Adapt if you use a different pip binary or you want to use a different luarocks version (latest was not working for me).
Ensure that hererocks is accessible after user pip installation (e.g. with `~/.local/bin` in `PATH`).

```vim
    Plug 'theHamsta/nvim_rocks', {'do': 'pip3 install --user hererocks && hererocks . -j2.1.0-beta3 -r3.0.0 && cp nvim_rocks.lua lua'}
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
nvim_rocks.ensure_installed('stdlib')

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

## Alternatives

If you want to install just pure Lua packages you might also install them manually:

```vim
    Plug 'Yonaba/30log', {'do': 'mkdir -p lua && cp *.lua lua'}
    Plug 'lua-stdlib/lua-stdlib', {'do': 'cp -r lib lua'}
```
