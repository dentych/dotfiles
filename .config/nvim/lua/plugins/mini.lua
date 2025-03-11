-- use this to open mini files at current location (instead of always from root dir)
local open_mini = function()
    local mf = require("mini.files")
    local path = vim.api.nvim_buf_get_name(0)

    if require("util").fileExists(path) then
        mf.open(vim.api.nvim_buf_get_name(0), false)
        mf.reveal_cwd()
    else
        mf.open(nil, false)
    end
end

return {
    {
        "echasnovski/mini.nvim",
        version = false,
        event = "VimEnter",
        config = function(_, config)
            require("mini.surround").setup()
            require("mini.pairs").setup()
            require("mini.comment").setup()
            require("mini.bufremove").setup()
            require("mini.ai").setup()
            require("mini.indentscope").setup()
            require("mini.files").setup()
            require("mini.icons").setup()
            require("mini.diff").setup()

            local starter = require("mini.starter")
            starter.setup({
                header = [[
888888ba                                      dP 888888ba   88888888b 
88    `8b                                     88 88    `8b  88        
88     88 .d8888b. 88d888b. 88d888b. .d8888b. 88 88     88 a88aaaa    
88     88 88'  `88 88'  `88 88'  `88 88ooood8 88 88     88  88        
88    .8P 88.  .88 88    88 88    88 88.  ... 88 88    .8P  88        
8888888P  `88888P' dP    dP dP    dP `88888P' dP 8888888P   88888888P 
                                                                      
                                                                      
                ]],
            })
        end,

        keys = {
            { "<leader>e", open_mini },
        },
    },
}
