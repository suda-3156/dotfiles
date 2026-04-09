-- Ref: https://docs.basedpyright.com/v1.21.0/configuration/language-server-settings
return {
  settings = {
    basedpyright = {
      analysis = {
        -- typeCheckingMode = "standard",
        diagnosticMode = "workspace",
        autoImportCompletions = true,
      },
    },
  },
}
