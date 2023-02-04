local au_vimrc = vim.api.nvim_create_augroup("vimrc", { clear = true })

vim.api.nvim_create_autocmd({"InsertEnter"}, {
  desc = "Show cursor line in insert mode",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.cursorlineopt = "both" end,
})

vim.api.nvim_create_autocmd({"InsertLeave"}, {
  desc = "Hide cursor line when leaving insert mode",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.cursorlineopt = "number" end,
})

vim.api.nvim_create_autocmd({"BufEnter", "WinEnter"}, {
  desc = "Show colorcolumn in the current buffer",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.colorcolumn = "+1" end,
})

vim.api.nvim_create_autocmd({"BufLeave", "WinLeave"}, {
  desc = "Hide colorcolumn when leaving the current buffer",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.wo.colorcolumn = "0" end,
})

vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  desc = "Do not insert the current comment leader after hitting o/O",
  group = au_vimrc,
  pattern = "*",
  callback = function() vim.opt_local.formatoptions:remove("o") end,
})

vim.api.nvim_create_autocmd({"BufEnter"}, {
  desc = "Auto change directory",
  group = au_vimrc,
  pattern = "*",
  command = "silent! lcd %:p:h:gs/ /\\ /"
})

vim.api.nvim_create_autocmd({"BufWritePre"}, {
  desc = "Remove trailing whitespaces on save",
  group = au_vimrc,
  pattern = "*",
  command = "%s/\\s\\+$//e",
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = "Jump to the last place in the file before exiting",
  group = au_vimrc,
  callback = function(data)
    -- https://github.com/numToStr/dotfiles/commit/49e6d6d
    local last_pos = vim.api.nvim_buf_get_mark(data.buf, '"')
    if last_pos[1] > 0 and last_pos[1] <= vim.api.nvim_buf_line_count(data.buf) then
      vim.api.nvim_win_set_cursor(0, last_pos)
    end
  end,
})

-- Automatically creates parent directories for the current file if they
-- don't exist yet (auto_mkdir based)
vim.api.nvim_create_autocmd({"BufWritePre", "FileWritePre"}, {
  desc = "Auto mkdir to a file",
  group = au_vimrc,
  pattern = "*",
  callback = function()
    vim.cmd [[
      let b:dir = expand('<afile>:p:h')
      \ | if !isdirectory(b:dir) && !(b:dir =~ '://')
      \ |   call mkdir(iconv(b:dir, &encoding, &termencoding), 'p')
      \ | endif
  ]]
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = au_vimrc,
  callback = function()
    vim.highlight.on_yank({ higroup = "Visual", timeout = 120 })
  end,
})

vim.api.nvim_create_autocmd({"FileType"}, {
  desc = "Close quickfix window by q key press",
  group =  vim.api.nvim_create_augroup("quickfix", { clear = true }),
  pattern = { "qf", "netrw" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<CMD>close<CR>', {
      buffer = event.buf, silent = true
    })
  end,
})

vim.api.nvim_create_autocmd({"BufWritePost"}, {
  desc = "Reloads Neovim after whenever you save plugins.lua",
  group = vim.api.nvim_create_augroup("Packer", { clear = true }),
  pattern = "plugins.lua",
  command = "source <afile> | PackerCompile"
})
