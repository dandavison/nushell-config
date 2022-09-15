let-env config = ($env.config | merge {
  {
    color_config: $light_theme
    disable_table_indexes: true
    cd_with_abbreviations: true
    show_banner: false
  }
})

source alias.nu
use lib.nu *
use project.nu *
use git.nu *
use git-stash.nu *
source prompt.nu
source env-dan.nu
source init-local.nu
