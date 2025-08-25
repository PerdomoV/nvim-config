-- lua/config/lsp.lua

-- TypeScript / JavaScript
vim.lsp.config.ts_ls = {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "package.json", "tsconfig.json", "jsconfig.json" },
  filetypes = {
    "typescript", "typescriptreact", "typescript.tsx",
    "javascript", "javascriptreact"
  },
}

-- PHP
vim.lsp.config.intelephense = {
  cmd = { "intelephense", "--stdio" },
  root_markers = { "composer.json", "intelephense.config.json" },
  filetypes = { "php" },
}

-- Next.js
vim.lsp.config.ts_next = {
  cmd = { "typescript-language-server", "--stdio" },
  root_markers = { "package.json", "tsconfig.json", "next.config.js" },
  filetypes = { "typescript.tsx", "javascriptreact" },
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

-- Inline errors:

-- Global diagnostics config
vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

-- Show diagnostics in a floating window on CursorHold
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Keymaps only when LSP attaches to a buffer
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }

    -- Hover docs
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    -- Go to definition
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    -- References
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    -- Rename symbol
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    -- Code actions
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
    -- Diagnostics navigation
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
  end,
})
