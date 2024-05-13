return {
    "williamboman/mason.nvim",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig",
    },
    config = function()
        require("mason").setup()
        require("mason-lspconfig").setup({
            ensure_installed = { "gopls", "omnisharp", "lua_ls", "rust_analyzer" },
        })

        local lsp_config = require("lspconfig")
        
        -- Diagnostic config
        vim.diagnostic.config({
            virtual_text = false,
        })
        
        -- Show diagnostics on hover
        vim.o.updatetime = 250
        vim.cmd [[autocmd! CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false, scope="cursor"})]]

        -- Lua
        lsp_config.lua_ls.setup({
            settings = {
                Lua = {
                    diagnostics = {
                        -- Get the language server to recognize the `vim` global
                        globals = { "vim" },
                    },
                    -- Do not send telemetry data containing a randomized but unique identifier
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })

        -- Rust
        lsp_config.rust_analyzer.setup{}

        -- Go
        lsp_config.gopls.setup{}

        -- C#
        lsp_config.omnisharp.setup{}
    end
}
