local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
  print("Installing packer close and reopen Neovim...")
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
)

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use 'wbthomason/packer.nvim' -- Have packer manage itself
  use 'nvim-lua/plenary.nvim'
  use 'nvim-treesitter/nvim-treesitter'
  use 'RRethy/nvim-base16'
  use 'windwp/nvim-autopairs'
  use 'nvim-tree/nvim-web-devicons'

  use {
  'nvim-lualine/lualine.nvim',
  requires = { {'nvim-tree/nvim-web-devicons', opt = true}} 
  } 
  
  use {'goolord/alpha-nvim',
    requires = { 'nvim-tree/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.startify'.config)
    end
  }

  use {
  'nvim-telescope/telescope.nvim', tag = '0.1.1',
  requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {'akinsho/bufferline.nvim',
  tag = "*",
  requires = 'nvim-tree/nvim-web-devicons'}

  use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons', -- optional
  },
  config = function()
    require("nvim-tree").setup {}
  end
}

  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
