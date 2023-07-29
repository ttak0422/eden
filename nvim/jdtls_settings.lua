-- https://github.com/eclipse/eclipse.jdt.ls/blob/master/org.eclipse.jdt.ls.core/src/org/eclipse/jdt/ls/core/internal/preferences/Preferences.java
-- https://github.com/redhat-developer/vscode-java/blob/master/package.json
return function(runtimes)
  return {
    java = {
      configuration = {
        runtimes = runtimes or {},
        updateBuildConfiguration = "automatic",
      },
      import = {
        gradle = {
          offline = {
            enabled = true,
          },
        },
        maven = {
          offline = {
            enabled = true,
          },
        },
      },
      maven = {
        downloadSources = true,
        updateSnapshots = true,
      },
      eclipse = {
        downloadSources = true,
      },
      format = {
        -- use google java format
        enabled = false,
      },
      referencesCodeLens = {
        enabled = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      signatureHelp = {
        enabled = true,
        description = {
          enabled = true,
        },
      },
      inlayHints = { parameterNames = { enabled = "all" } },
      completion = {
        favoriteStaticMembers = {
          "org.assertj.core.api.Assertions.assertThat",
          "org.assertj.core.api.Assertions.assertThatCode",
          "org.junit.jupiter.params.provider.Arguments.arguments",
          "org.mockito.Mockito.*",
        },
        chain = {
          enabled = true,
        },
        lazyResolveTextEdit = {
          enabled = false,
        }
      },
      autobuild = {
        enabled = true,
      },
      errors = {
        incompleteClasspath = {
          severity = "ignore",
        },
      },
    },
  }
end
