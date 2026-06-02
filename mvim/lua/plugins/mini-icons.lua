-- Icon provider that mocks nvim-web-devicons for compatibility.
return {
  'echasnovski/mini.icons',
  lazy = false,
  init = function()
    package.preload['nvim-web-devicons'] = function()
      require('mini.icons').mock_nvim_web_devicons()
      return package.loaded['nvim-web-devicons']
    end
  end,
  opts = {},
}
