return {
  settings = {
    Lua = {
      completion = {
        enable = true,
      },
      diagnostics = {
        enable = true,
        globals = { 'vim' },
      },
      format = {
        enable = false,
      },
      runtime = {
        version = 'LuaJIT',
      },
      telemetry = { enable = false },
      workspace = {
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
}
