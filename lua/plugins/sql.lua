return {
  "tpope/vim-dadbod",
  dependencies = {
    { "kristijanhusak/vim-dadbod-ui", cmd = { "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" } },
  },
  cmd = { "DB", "DBUI", "DBUIToggle", "DBUIAddConnection", "DBUIFindBuffer" },
  init = function()
    vim.g.db_ui_save_location = vim.fn.stdpath("data") .. "/dadbod"
  end,
}
