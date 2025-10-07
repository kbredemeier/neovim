return {
  "avante.nvim",
  cmd = { "AvanteAsk" },
  after = function(plugin)
    require("avante").setup({
      instructions_file = "avante.md",
      -- for example
      -- provider = "claude",
      -- providers = {
      --   claude = {
      --     -- endpoint = "https://api.anthropic.com",
      --     -- model = "claude-sonnet-4-20250514",
      --     endpoint = "https://api.githubcopilot.com",
      --     model = "claude-4.5-sonnet",
      --     timeout = 30000, -- Timeout in milliseconds
      --       extra_request_body = {
      --         temperature = 0.75,
      --         max_tokens = 20480,
      --       },
      --   },
      -- },
      provider = "copilot",
      providers = {
        copilot = {
	  -- https://docs.claude.com/en/docs/about-claude/models/overview
          -- model = "claude-opus-4-1-20250805",
          model = "claude-sonnet-4",
          -- model = "claude-sonnet-4-20250514",
          extra_request_body = {
            temperature = 0.75,
            -- max_tokens = 20480,
            max_tokens = 4096,
          },
        },
      },
    })
  end,
}
