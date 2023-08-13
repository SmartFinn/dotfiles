local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
	print("Installing lazy.nvim plugin manager...")
end
vim.opt.rtp:prepend(lazypath)

local has_lazy, lazy = pcall(require, "lazy")
if not has_lazy then
  vim.notify("lazy.nvim is not installed")
  return
end

lazy.setup("plugins")
