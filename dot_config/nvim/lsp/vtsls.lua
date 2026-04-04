return {
  settings = {
    vtsls = {
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
          entriesLimit = 1337,
        },
      },
    },
    typescript = {
      tsserver = {
        experimental = {
          -- NOTE: Some projects will crawl to a halt when this is enabled
          -- enableProjectDiagnostics = true,
        },
        maxTsServerMemory = 8192,
      },
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
      updateImportsOnFileMove = 'always',
    },
    javascript = {
      preferences = {
        importModuleSpecifier = 'non-relative',
      },
      updateImportsOnFileMove = 'always',
    },
  },
}
