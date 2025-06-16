return {
  {
    "elixir-tools.nvim",
    event = { "BuffReadPre", "BufNewFile" },
    after = function(_)
      local elixir = require("elixir")
      local elixirls = require("elixir.elixirls")
      elixir.setup({
        on_attach = function()
          vim.keymap.set(
            "n",
            "<space>fp",
            ":ElixirFromPipe<cr>",
            { buffer = true, noremap = true },
            { desc = "Elixir [F]rom [P]ipe" }
          )
          vim.keymap.set(
            "n",
            "<space>tp",
            ":ElixirToPipe<cr>",
            { buffer = true, noremap = true },
            { desc = "Elixir [T]o [P]ipe" }
          )
          vim.keymap.set(
            "v",
            "<space>em",
            ":ElixirExpandMacro<cr>",
            { buffer = true, noremap = true },
            { desc = "Elixir [E]xpand [M]acro" }
          )
        end,

        nextls = { enable = false },
        projectionist = { enable = true },
        elixirls = {
          enable = true,
          path = { "elixir-ls" },
          settings = elixirls.settings({
            dialyzerEnabled = true,
            fetchDeps = false,
            enableTestLenses = true,
            suggestSpecs = true,
          }),
        },
      })
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()
      luasnip.config.setup({})

      local ls = require("luasnip")

      vim.keymap.set({ "i", "s" }, "<M-n>", function()
        if ls.choice_active() then
          ls.change_choice(1)
        end
      end)
    end,
  },
}
