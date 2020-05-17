if exists('g:loaded_nvim_rocks')
  finish
endif

command! -nargs=1 NvimRocksInstall lua require'nvim_rocks'.install(<f-args>)

let g:loaded_nvim_rocks = 1
