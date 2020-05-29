if exists('g:loaded_nvim_rocks')
  finish
endif

command! -nargs=1 NvimRocksInstall lua require'nvim_rocks'.install(<f-args>)
command! -nargs=1 NvimRocksRemove lua require'nvim_rocks'.remove(<f-args>)
command! NvimRocksList lua print(vim.inspect(require'nvim_rocks'.list()))

let g:loaded_nvim_rocks = 1
