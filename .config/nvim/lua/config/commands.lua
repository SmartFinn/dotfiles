-- Aliases
vim.cmd.cabbrev('ft', 'setfiletype')
vim.cmd.cabbrev('<expr>', '%%', "expand('%:p:h')")

-- Type :enc= for set encoding
vim.cmd.cabbrev('<expr>', 'enc', "expand('e! ++enc')")

-- Type :ff= for set fileformats
vim.cmd.cabbrev('<expr>', 'ff', "expand('e! ++ff')")

-- Command corrections
vim.cmd.cabbrev('W', 'w')
vim.cmd.cabbrev('Q', 'q')
vim.cmd.cabbrev('man', 'Man')

-- Reverse lines in the opposite direction
vim.api.nvim_create_user_command(
  'Reverse', ':<line1>,<line2>g/^/m0 | nohlsearch',
  { range = '%' }
)
