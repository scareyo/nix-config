return {
    'freddiehaddad/feline.nvim',
    dependencies = {
        "catppuccin/nvim"
    },
    config = function()
        local ctp_feline = require('catppuccin.groups.integrations.feline')

        ctp_feline.setup{}

        require("feline").setup {
            components = ctp_feline.get(),
        }
    end
}
