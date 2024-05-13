return {
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("catppuccin").setup {
            nvimtree = true,
        }
        vim.cmd([[colorscheme catppuccin]])
    end
}
