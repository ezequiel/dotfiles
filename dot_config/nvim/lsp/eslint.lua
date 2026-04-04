return {
  filetypes = {
    'html',
    'htmlangular',
    'javascript',
    'javascriptreact',
    'json',
    'jsonc',
    'typescript',
    'typescriptreact',
  },
  settings = {
    experimental = {
      useFlatConfig = true,
    },
    run = 'onType',
    workingDirectory = {
      mode = 'auto',
    },
  },
}
