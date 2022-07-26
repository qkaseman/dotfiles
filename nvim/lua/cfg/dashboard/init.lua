local ok, db = pcall(require, 'dashboard')
if not ok then
  return
end

db.custom_center = {
  { icon = '  ', desc = 'New file                            ', action = 'enew' }, -- longer desc b/c no shortcut
  { icon = '  ', desc = 'Find file                      ', shortcut = 'SPC f', action = 'Telescope find_files' },
  { icon = '  ', desc = 'Recent files                   ', shortcut = 'SPC h', action = 'Telescope oldfiles' },
  { icon = '  ', desc = 'Find Word                      ', shortcut = 'SPC r', action = 'Telescope live_grep' },
}
