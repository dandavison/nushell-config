let-env config = ($env.config | merge {
  {
    color_config: $light_theme
    disable_table_indexes: true
    cd_with_abbreviations: true
    show_banner: false
  }
})

use lib.nu *
use git-stash.nu *
source prompt.nu
source alias.nu
source env-dan.nu
source init-local.nu
