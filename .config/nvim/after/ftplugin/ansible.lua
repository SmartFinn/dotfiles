-- Ansible specific settings.
-- Options
vim.opt_local.tabstop = 2
vim.opt_local.shiftwidth = 2
vim.opt_local.shiftround = true
vim.opt_local.expandtab = true
vim.opt_local.foldmethod = "indent"
vim.opt_local.wrap = false

-- Docs
local api = vim.api
if vim.fn.executable('ansible-doc') then
  vim.bo.keywordprg = ':sp term://PAGER=cat ansible-doc'
end

-- goto file: search for files in files and templates dirs
local fname = api.nvim_buf_get_name(0)
if fname:find('tasks/') then
  local paths = {
    vim.bo.path,
    vim.fs.dirname(fname:gsub("tasks/", "files/")),
    vim.fs.dirname(fname:gsub("tasks/", "templates/")),
    vim.fs.dirname(fname)
  }
  vim.bo.path = table.concat(paths, ",")
end

-- Abbreviations

vim.cmd.iabbrev('-:', '- name:')
vim.cmd.iabbrev('b:', 'become:')
vim.cmd.iabbrev('e:', 'environment:')
vim.cmd.iabbrev('l:', 'loop:')
vim.cmd.iabbrev('n:', 'name:')
vim.cmd.iabbrev('o:', 'notify:')
vim.cmd.iabbrev('p:', 'path:')
vim.cmd.iabbrev('r:', 'register:')
vim.cmd.iabbrev('s:', 'state:')
vim.cmd.iabbrev('t:', 'tags:')
vim.cmd.iabbrev('w:', 'when:')
vim.cmd.iabbrev('ogm:', 'owner: root\ngroup: root\nmode: \'0644\'')

-- Compiler

-- Syntax

-- Macros

-- Mapping

-- Plugins
