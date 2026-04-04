return {
  init_options = {
    command = {
      'golangci-lint',
      'run',
      '--fast',
      '--out-format=json',
      '--show-stats=false',
      '--issues-exit-code=1',
    },
  },
}
