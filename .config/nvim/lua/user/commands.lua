-- Aliases
vim.cmd.abbrev('ft', 'setfiletype')
vim.cmd.abbrev('<expr>', '%%', "expand('%:p:h')")

-- Type :enc= for set encoding
vim.cmd.abbrev('<expr>', 'enc', "expand('e! ++enc')")

-- Type :ff= for set fileformats
vim.cmd.abbrev('<expr>', 'ff', "expand('e! ++ff')")

-- Command corrections
vim.cmd.abbrev('W', 'w')
vim.cmd.abbrev('Q', 'q')
vim.cmd.abbrev('man', 'Man')
