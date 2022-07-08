-- Modes
--  'n' - normal mode
--  'i' - insert mode
--  'v' - visual mode
--  'x' - visual block mode
--  't' - term mode
--  'c' - command mode
--  ''  - equivalent of ':map' (nvo)
--  '!' - equivalent of ':map!'
local keymap = require 'lib.keymap'.keymap

-- Make semicolon into colon, because lazy.
keymap('', ';', ':')
