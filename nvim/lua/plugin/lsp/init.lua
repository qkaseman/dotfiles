-- TODO: Make a map of server name to config and use that rather
-- than manually specifying them.

local servers = {
  'tsserver'
}
require('plugin.lsp.installer').install(servers)

require('plugin.lsp.server.tsserver')
