export def and-then [block: block] {
  if not ($in | is-empty) {
    do $block
  }
}

export def or-else [block: block] {
  if not ($in | is-empty) {
    $in
  } else {
    do $block
  }
}
