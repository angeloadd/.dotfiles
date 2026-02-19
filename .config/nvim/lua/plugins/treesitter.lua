return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    -- add tsx and treesitter
    vim.list_extend(opts.ensure_installed, {
      "php",
      "java",
      "kotlin",
      "go",
      "gomod",
      "gosum",
      "angular",
      "git_config",
      "gitignore",
      "make",
      "phpdoc",
      "scss",
      "css",
      "jsonnet",
      "templ",
    })
  end,
}
