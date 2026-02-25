-- fzf-lua has issues, use telescope instead
return {
    {
      "ibhagwan/fzf-lua",
      -- optional for icon support
      dependencies = { "nvim-tree/nvim-web-devicons" },
      config = function ()
	  require("fzf-lua").setup({})
      end
    }
}
