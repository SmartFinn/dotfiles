-- Filetype detection
--

local function ftdetect_ansible_playbook(bufnr)
  for _, line in ipairs(vim.api.nvim_buf_get_lines(bufnr, 1, 10, false)) do
    if line:find('^-?%s+hosts:')
    then
      return 'yaml.ansible'
    end
  end

  return 'yaml'
end

vim.filetype.add({
  extension = {
    ['j2'] = 'htmldjango',
    ['SVG'] = 'svg',
    ['yml'] = function(_, bufnr) return ftdetect_ansible_playbook(bufnr) end,
    ['yaml'] = function(_, bufnr) return ftdetect_ansible_playbook(bufnr) end,
    ['automount'] = 'systemd',
    ['device'] = 'systemd',
    ['mount'] = 'systemd',
    ['path'] = 'systemd',
    ['scope'] = 'systemd',
    ['service'] = 'systemd',
    ['slice'] = 'systemd',
    ['socket'] = 'systemd',
    ['swap'] = 'systemd',
    ['target'] = 'systemd',
    ['timer'] = 'systemd',
  },
  filename = {
    Brewfile = 'ruby',
    justfile = 'just',
    Justfile = 'just',
    Tmuxfile = 'tmux',
    ['go.sum'] = 'go',
    ['yarn.lock'] = 'yaml',
    ['.buckconfig'] = 'toml',
    ['.flowconfig'] = 'ini',
    ['.tern-project'] = 'json',
    ['.jsbeautifyrc'] = 'json',
    ['.jscsrc'] = 'json',
    ['.watchmanconfig'] = 'json',
  },
  pattern = {
    ['.*%.js%.map'] = 'json',
    ['.*%.postman_collection'] = 'json',
    ['Jenkinsfile.*'] = 'groovy',
    ['%.kube/config'] = 'yaml',
    ['%.config/git/users/.*'] = 'gitconfig',
    ['.*/templates/.*%.ya?ml'] = 'helm',
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/playbooks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/roles?/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/tasks/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/inventory/.*%.yml'] = 'yaml.ansible',
    ['.*/inventories/.*%.yml'] = 'yaml.ansible',
    ['.*/host_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/group_vars/.*%.ya?ml'] = 'yaml.ansible',
    ['.*/inventory/.*'] = { 'ini', { priority = -1 } },
    ['.*/inventories/.*'] = { 'ini', { priority = -1 } },
  },
})
