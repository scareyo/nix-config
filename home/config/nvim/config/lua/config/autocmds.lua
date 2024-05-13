vim.api.nvim_create_autocmd("VimEnter", {
    command = "silent !kitty @ set-spacing padding=0"
})

vim.api.nvim_create_autocmd("VimLeave", {
    callback = function()
        -- Only when exiting to kitty
        if (os.getenv("TERM") == "xterm-kitty") then
            vim.api.nvim_command("silent !kitty @ set-spacing padding=10 padding-top=0")
        end
    end,
})

vim.api.nvim_create_autocmd("BufEnter", {
    callback = function()
        -- Language specific options
        if (vim.bo.filetype == "dart") then
            vim.opt.shiftwidth = 2
            vim.opt.softtabstop = 2
        end
        if (vim.bo.filetype == "nix") then
            vim.opt.shiftwidth = 2
            vim.opt.softtabstop = 2
        end
    end,
})
