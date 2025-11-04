return {
    'kyza0d/xeno.nvim',
    lazy = false,
    priority = 1000,
    config = function()
        require('xeno').new_theme('xeno-pink-haze', {
            base = '#0f0c0e',
            accent = '#D19EBC',
            contrast = 0.1,
        })
        vim.cmd('colorscheme xeno-pink-haze')
    end,
}
