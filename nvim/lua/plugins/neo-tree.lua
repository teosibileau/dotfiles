return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    filesystem = {
      window = {
        mappings = {
          ["Z"] = "expand_all_nodes",
        },
      },
      filtered_items = {
        visible = {
          hidden = true,
        },
        dotfiles = true,
        hide_gitignored = false,
      },
    },
  },
}
