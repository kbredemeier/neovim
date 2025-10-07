return {
  "avante.nvim",
  on_plugin = { "nui.nvim" },
  after = function(plugin)
    require("avante").setup({
      instructions_file = "avante.md",
      -- for example
      provider = "claude",
      providers = {
        claude = {
          -- endpoint = "https://api.anthropic.com",
          -- model = "claude-sonnet-4-20250514",
          endpoint = "https://api.githubcopilot.vom",
          model = "Claude Sonnet 4.5",
          timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0.75,
              max_tokens = 20480,
            },
        },
      },
    })
  end,
}
