-- https://github.com/eclipse/eclipse.jdt.ls/blob/master/org.eclipse.jdt.ls.core/src/org/eclipse/jdt/ls/core/internal/preferences/Preferences.java
-- https://github.com/redhat-developer/vscode-java/blob/master/package.json
return function(runtimes)
  return {
    java = {
      configuration = {
        runtimes = runtimes or {},
        updateBuildConfiguration = "automatic",
      },
      jdt = {
        ls = {
          lombokSupport = {
            true,
          },
          protobufSupport = {
            true,
          },
          androidSupport = {
            true,
          },
        },
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
        filteredTypes = {
          "java.awt.*",
          "com.sun.*",
          "sun.*",
          "jdk.*",
          "org.graalvm.*",
          "io.micrometer.shaded.*",
        },
        favoriteStaticMembers = {
          "org.junit.Assert.*",
          "org.junit.Assume.*",
          "org.junit.jupiter.api.Assertions.*",
          "org.junit.jupiter.api.Assumptions.*",
          "org.junit.jupiter.api.DynamicContainer.*",
          "org.junit.jupiter.api.DynamicTest.*",
          "org.assertj.core.api.Assertions.*",
          "org.mockito.Mockito.*",
          "org.mockito.ArgumentMatchers.*",
          "org.mockito.Answers.*",
          "org.mockito.Mockito.*",
        },
        importOrder = {
          "#",
          "java",
          "javax",
          "jakarta",
          "org",
          "com",
          "",
        },
        matchCase = "firstLetter",
        guessMethodArguments = true,
        chain = {
          enabled = false,
        },
        lazyResolveTextEdit = {
          enabled = true,
        },
        edit = {
          validateAllOpenBuffersOnChanges = false,
        },
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
