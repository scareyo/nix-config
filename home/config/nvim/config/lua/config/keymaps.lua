vim.keymap.set('n', '<LEFT>', function() vim.api.nvim_command('BufferLineCyclePrev') end)
vim.keymap.set('n', '<RIGHT>', function() vim.api.nvim_command('BufferLineCycleNext') end)
vim.keymap.set('n', '<leader><LEFT>', function() vim.api.nvim_command('BufferLineMovePrev') end)
vim.keymap.set('n', '<leader><RIGHT>', function() vim.api.nvim_command('BufferLineMoveNext') end)

-- Close file
vim.keymap.set('n', '<leader>q', function()
    -- Exit if file has unsaved changes
    if (vim.bo.modified) then
        print("There are unsaved changes")
        return
    end

    local target_buffer = vim.api.nvim_get_current_buf()
    vim.api.nvim_command('bprev')
    vim.api.nvim_command('bd ' .. target_buffer)
end)

vim.keymap.set('n', "<leader><TAB>", function() vim.api.nvim_command("NvimTreeToggle") end)
vim.keymap.set('n', "<leader>t", function() vim.api.nvim_command("Telescope") end)
vim.keymap.set('n', "<leader>b", function() vim.api.nvim_command("DapToggleBreakpoint") end)
vim.keymap.set('n', "<leader>d", function() vim.api.nvim_command("DapUiToggle") end)
