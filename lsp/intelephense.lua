return {
  init_options = {
    licenceKey = os.getenv("INTELEPHENSE_LICENSE"),
  },
  root_markers = {
    "phpcs.xml",
    "phpcs.xml.dist",
    "composer.json",
    ".git",
  },
  settings = {
    intelephense = {
      environment = { phpVersion = "8.2" },
      files = { maxSize = 5000000 },
      telemetry = { enabled = false },
    },
  },
}
