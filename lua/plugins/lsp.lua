local servers = {
  -- python
  ruff = {},
  pyright = {
    settings = {
      pyright = { autoImportCompletion = true },
      python = {
        analysis = {
          autoSearchPaths = true,
          diagnosticMode = 'openFilesOnly',
          useLibraryCodeForTypes = true,
          typeCheckingMode = 'off',
        },
      },
    },
  },

  -- tailwind
  tailwindcss = {},

  -- ts/js
  eslint = {},
  ts_ls = {},

  -- nvim
  lua_ls = {
    settings = {
      Lua = {
        completion = {
          callSnippet = 'Replace',
        },
        diagnostics = { disable = { 'missing-fields' } },
      },
    },
  },

  -- infra
  terraformls = {},
  yamlls = {},
}

return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('pmdev-lsp-attach', { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = desc })
        end

        map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
        map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
        map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
        map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
        map('<leader>ss', require('telescope.builtin').lsp_document_symbols, '[S]earch Document [S]ymbols')
        map('<leader>s*', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[S]earch Workspace Symbols')
        map('<leader>r', vim.lsp.buf.rename, '[R]ename')
        map('K', vim.lsp.buf.hover, 'Hover Documentation')
        map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.server_capabilities.documentHighlightProvider then
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.document_highlight,
          })

          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

    require('mason').setup()

    require('mason-lspconfig').setup {
      automatic_enable = false,
    }

    require('mason-tool-installer').setup {
      ensure_installed = {
        'stylua',
        'lua-language-server',
        'pyright',
        'ruff',
        'eslint-lsp',
        'typescript-language-server',
        'tailwindcss-language-server',
        'terraform-ls',
        'yaml-language-server',
        'vue-language-server',
      },
    }

    -- Configure vue and typescript servers manually
    local lspconfig = require 'lspconfig'

    for server_name, config in pairs(servers) do
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      lspconfig[server_name].setup(config)
    end

    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
    }

    lspconfig.volar.setup {
      capabilities = capabilities,
      filetypes = { 'vue' },
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
    }
  end,
}
