-- lua/config/lsp.lua

-- TypeScript / JavaScript (unified configuration)
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { 
    "package.json", 
    "tsconfig.json", 
    "jsconfig.json",
    ".git"
  },
  filetypes = {
    "typescript", 
    "typescriptreact", 
    "typescript.tsx",
    "javascript", 
    "javascriptreact",
    "jsx"
  },
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      }
    }
  },
  init_options = {
    preferences = {
      disableSuggestions = false,
    }
  }
}

-- PHP
vim.lsp.config.intelephense = {
  cmd = { "intelephense", "--stdio" },
  root_markers = { "composer.json", "intelephense.config.json", ".git" },
  filetypes = { "php" },
}

-- Enable servers
local cmp_lsp = require("cmp_nvim_lsp")

vim.lsp.enable("ts_ls", {
  capabilities = cmp_lsp.default_capabilities(),
})

vim.lsp.enable("intelephense", {
  capabilities = cmp_lsp.default_capabilities(),
})

-- Optional completion/hover
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.o.winborder = "rounded"

-- Enhanced diagnostics config for better type error visibility
vim.diagnostic.config({
  virtual_text = {
    enabled = true,
    source = "if_many",
    spacing = 4,
    prefix = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "✘",
      [vim.diagnostic.severity.WARN] = "▲",
      [vim.diagnostic.severity.HINT] = "⚑",
      [vim.diagnostic.severity.INFO] = "»",
    }
  },
  underline = true,
  update_in_insert = false,
  severity_sort = true,
  float = {
    focusable = true,
    style = "minimal",
    border = "rounded",
    source = "always",
    header = "",
    prefix = "",
  },
})

-- Show diagnostics in a floating window on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { 
      focus = false,
      scope = "cursor"
    })
  end,
})

-- Reduce CursorHold time for faster diagnostics popup
vim.o.updatetime = 250

-- Keymaps only when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- Hover docs
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- Go to type definition
    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
    -- References
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- Implementation
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    -- Show diagnostics in location list
    vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, opts)
    -- Show all workspace diagnostics
    vim.keymap.set("n", "<leader>da", vim.diagnostic.setqflist, opts)
  end,
})

-- Force LSP to refresh diagnostics when switching buffers
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.defer_fn(function()
      vim.diagnostic.show(nil, 0)
    end, 100)
  end,
})

-- Auto-format on save for TypeScript files (optional)
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.ts", "*.tsx", "*.js", "*.jsx" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
