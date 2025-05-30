
local status_ok, obsidian = pcall(require, "obsidian")
if not status_ok then
  return
end

obsidian.setup {
  workspaces = {
    {
      name = "yotam",
      path = "~/vaults/yotam"
    },
  },
  completion = {
    nvim_cmp = true, -- enable completion
  },
}

vim.keymap.set("n", "<leader>of", ":ObsidianFollowLink<CR>")
vim.keymap.set("n", "<leader>oo", ":ObsidianQuickSwitch<CR>")
vim.keymap.set("n", "<leader>ot", ":ObsidianToday<CR>")
vim.keymap.set("n", "<leader>ob", ":ObsidianBackLinks<CR>")
