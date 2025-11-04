local colorschemeName = nixCats("colorscheme")

-- Could I lazy load on colorscheme with lze?
-- sure. But I was going to call vim.cmd.colorscheme() during startup anyway
-- this is just an example, feel free to do a better job!
vim.cmd.colorscheme(colorschemeName)

local ok, notify = pcall(require, "notify")
if ok then
  notify.setup({
    on_open = function(win)
      vim.api.nvim_win_set_config(win, { focusable = false })
    end,
  })
  vim.notify = notify
  vim.keymap.set("n", "<Esc>", function()
    notify.dismiss({ silent = true })
  end, { desc = "dismiss notify popup and clear hlsearch" })
end

vim.g.loaded_netrwPlugin = 1

require("oil").setup({
  default_file_explorer = true,
  view_options = {
    show_hidden = true,
  },
  columns = {
    "icon",
    "permissions",
    "size",
    -- "mtime",
  },
  keymaps = {
    ["g?"] = "actions.show_help",
    ["<CR>"] = "actions.select",
    ["<C-s>"] = "actions.select_vsplit",
    ["<C-h>"] = "actions.select_split",
    ["<C-t>"] = "actions.select_tab",
    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-l>"] = "actions.refresh",
    ["-"] = "actions.parent",
    ["_"] = "actions.open_cwd",
    ["`"] = "actions.cd",
    ["~"] = "actions.tcd",
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",
  },
})
vim.keymap.set("n", "-", "<cmd>Oil<CR>", { noremap = true, desc = "Open Parent Directory" })
vim.keymap.set("n", "<leader>-", "<cmd>Oil .<CR>", { noremap = true, desc = "Open nvim root directory" })

require("lze").load({
  { import = "piratenpete.plugins.telescope" },
  { import = "piratenpete.plugins.treesitter" },
  { import = "piratenpete.plugins.completion" },
  { import = "piratenpete.plugins.elixir" },
  { import = "piratenpete.plugins.llm" },
  {
    "nui.nvim",
    -- def_of = { "avante.nvim" },
    on_require = "nui",
  },
  {
    "mini.pick",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("mini.pick").setup()
    end,
  },
  {
    "snacks.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("snacks").setup({
        input = { enabled = true },
      })
    end,
  },
  -- Copilot is only required to setup authentication and get the API token
  {
    "copilot.lua",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },
  {
    "render-markdown.nvim",
    -- on_require = { "nvim-treesitter" },
    ft = { "markdown", "Avante" },
    on_require = "render-markdown",
    -- def_of = { "avante.nvim" },
    -- after = function(plugin)
    --   require("render-markdown").setup({
    --     file_types = { "markdown", "Avante" },
    --   })
    -- end,
  },
  {
    "undotree",
    cmd = { "UndotreeToggle", "UndotreeHide", "UndotreeShow", "UndotreeFocus", "UndotreePersistUndo" },
    keys = { { "<leader>U", "<cmd>UndotreeToggle<CR>", mode = { "n" }, desc = "Undo Tree" } },
    before = function(_)
      vim.g.undotree_WindowLayout = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
  {
    "comment.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("Comment").setup()
    end,
  },
  {
    "hop.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      local hop = require("hop")
      local directions = require("hop.hint").HintDirection

      hop.setup({
        keys = "etovxqpdygfblzhckisuran",
      })

      vim.keymap.set("n", "<leader><leader>w", function()
        hop.hint_words({ direction = directions.AFTER_CURSOR })
      end, { desc = "Move to word after cursor" })

      vim.keymap.set("n", "<leader><leader>W", function()
        hop.hint_words({ direction = directions.BEFORE_CURSOR })
      end, { desc = "Move to word before cursor" })
    end,
  },
  -- {
  --   "nvim-spider",
  --   event = "DeferredUIEnter",
  --   after = function(plugin)
  --     local spider = require("spider")
  --
  --     spider.setup({})
  --
  --     vim.keymap.set({ "n", "o", "x" }, "<C-w>", function()
  --       spider.motion("w")
  --     end, {})
  --
  --     vim.keymap.set({ "n", "o", "x" }, "<C-e>", function()
  --       spider.motion("e")
  --     end, {})
  --
  --     vim.keymap.set({ "n", "o", "x" }, "<C-b>", function()
  --       spider.motion("b")
  --     end, {})
  --   end,
  -- },
  {
    "vim-test",
    event = "DeferredUIEnter",
    after = function(_)
      vim.g["test#strategy"] = "neovim"
      vim.keymap.set("n", "<leader>tn", "<cmd>TestNearest<CR>", { desc = "[T]est [N]earest" })
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>", { desc = "[T]est [F]ile" })
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>", { desc = "[T]est [L]ast" })
    end,
  },
  {
    "indent-blankline.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("ibl").setup()
    end,
  },
  {
    "guess-indent.nvim",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("guess-indent").setup({})
    end,
  },
  {
    "nvim-autopairs",
    event = "DeferredUIEnter",
    after = function(plugin)
      require("nvim-autopairs").setup({})
    end,
  },
  {
    "mini-surround",
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require("mini.surround").setup({})
    end,
  },
  {
    "todo-comments.nvim",
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require("todo-comments").setup({})
    end,
  },
  {
    "trouble.nvim",
    -- event = "DeferredUIEnter",
    -- cmd = "Trouble",
    -- keys = "",
    keys = {
      {
        "<leader>td",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "[T]toggle [D]iagnostics",
      },
      {
        "<leader>tbd",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "[T]oggle [B]uffer [D]iagnostics",
      },
      {
        "<leader>ts",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "[T]oggle [S]ymbols",
      },
    },
    after = function(plugin)
      require("trouble").setup({})
      for i, entry in ipairs(plugin.keys) do
        local args = {}
        for j = 1, #entry do
          args[j] = entry[j]
        end

        local options = {}
        for k, v in pairs(entry) do
          if type(k) ~= "number" then
            options[k] = v
          end
        end

        vim.keymap.set("n", args[1], args[2], options)
      end
    end,
  },
  {
    "vim-startuptime",
    cmd = { "StartupTime" },
    before = function(_)
      vim.g.startuptime_event_width = 0
      vim.g.startuptime_tries = 10
      vim.g.startuptime_exe_path = nixCats.packageBinPath
    end,
  },
  {
    "fidget.nvim",
    event = "DeferredUIEnter",
    -- keys = "",
    after = function(plugin)
      require("fidget").setup({
        progress = {
          poll_rate = 10,
        },
      })
    end,
  },
  {
    "actions-preview.nvim",
    event = "DeferredUIEnter",
    dep_of = { "nvim-lspconfig" },
    -- keys = "",
    after = function(plugin)
      require("actions-preview").setup({})
      vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)
    end,
  },
  {
    "lsp_signature.nvim",
    event = "InsertEnter",
    -- on_require = { "lsp_signature" },
    dep_of = { "nvim-lspconfig" },
    -- keys = "",
    after = function(plugin)
      require("lsp_signature").setup({ bind = true })
    end,
  },
  -- {
  --   "hlargs",
  --   for_cat = 'general.extra',
  --   event = "DeferredUIEnter",
  --   -- keys = "",
  --   dep_of = { "nvim-lspconfig" },
  --   after = function(plugin)
  --     require('hlargs').setup {
  --       color = '#32a88f',
  --     }
  --     vim.cmd([[hi clear @lsp.type.parameter]])
  --     vim.cmd([[hi link @lsp.type.parameter Hlargs]])
  --   end,
  -- },
  {
    "lualine.nvim",
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      require("lualine").setup({
        options = {
          icons_enabled = false,
          theme = colorschemeName,
          component_separators = "|",
          section_separators = "",
        },
        sections = {
          lualine_c = {
            {
              "filename",
              path = 1,
              status = true,
            },
          },
        },
        inactive_sections = {
          lualine_b = {
            {
              "filename",
              path = 3,
              status = true,
            },
          },
          lualine_x = { "filetype" },
        },
        tabline = {
          lualine_a = { "buffers" },
          -- if you use lualine-lsp-progress, I have mine here instead of fidget
          -- lualine_b = { 'lsp_progress', },
          lualine_z = { "tabs" },
        },
      })
    end,
  },
  {
    "gitsigns.nvim",
    event = "DeferredUIEnter",
    -- cmd = { "" },
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      require("gitsigns").setup({
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = "+" },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map({ "n", "v" }, "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Jump to next hunk" })

          map({ "n", "v" }, "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, { expr = true, desc = "Jump to previous hunk" })

          -- Actions
          -- visual mode
          map("v", "<leader>hs", function()
            gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "stage git hunk" })
          map("v", "<leader>hr", function()
            gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
          end, { desc = "reset git hunk" })
          -- normal mode
          map("n", "<leader>gs", gs.stage_hunk, { desc = "git stage hunk" })
          map("n", "<leader>gr", gs.reset_hunk, { desc = "git reset hunk" })
          map("n", "<leader>gS", gs.stage_buffer, { desc = "git Stage buffer" })
          map("n", "<leader>gu", gs.undo_stage_hunk, { desc = "undo stage hunk" })
          map("n", "<leader>gR", gs.reset_buffer, { desc = "git Reset buffer" })
          map("n", "<leader>gp", gs.preview_hunk, { desc = "preview git hunk" })
          map("n", "<leader>gb", function()
            gs.blame_line({ full = false })
          end, { desc = "git blame line" })
          map("n", "<leader>gd", gs.diffthis, { desc = "git diff against index" })
          map("n", "<leader>gD", function()
            gs.diffthis("~")
          end, { desc = "git diff against last commit" })

          -- Toggles
          map("n", "<leader>gtb", gs.toggle_current_line_blame, { desc = "toggle git blame line" })
          map("n", "<leader>gtd", gs.toggle_deleted, { desc = "toggle git show deleted" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "select git hunk" })
        end,
      })
      vim.cmd([[hi GitSignsAdd guifg=#04de21]])
      vim.cmd([[hi GitSignsChange guifg=#83fce6]])
      vim.cmd([[hi GitSignsDelete guifg=#fa2525]])
    end,
  },
  {
    "which-key.nvim",
    -- cmd = { "" },
    event = "DeferredUIEnter",
    -- ft = "",
    -- keys = "",
    -- colorscheme = "",
    after = function(plugin)
      require("which-key").setup({})
      require("which-key").add({
        { "<leader><leader>",  group = "buffer commands" },
        { "<leader><leader>_", hidden = true },
        { "<leader>c",         group = "[c]ode" },
        { "<leader>c_",        hidden = true },
        { "<leader>d",         group = "[d]ocument" },
        { "<leader>d_",        hidden = true },
        { "<leader>g",         group = "[g]it" },
        { "<leader>g_",        hidden = true },
        { "<leader>m",         group = "[m]arkdown" },
        { "<leader>m_",        hidden = true },
        { "<leader>r",         group = "[r]ename" },
        { "<leader>r_",        hidden = true },
        { "<leader>s",         group = "[s]earch" },
        { "<leader>s_",        hidden = true },
        { "<leader>t",         group = "[t]oggles" },
        { "<leader>t_",        hidden = true },
        { "<leader>w",         group = "[w]orkspace" },
        { "<leader>w_",        hidden = true },
      })
    end,
  },
})
