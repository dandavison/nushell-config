# If input is non-empty, return result of evaluating block on input,
# otherwise return null.
export def and-then [block: block] {
  if not ($in | is-empty) {
    do $block
  }
}

# If input is empty, return result of evaluating block,
# otherwise return input.
export def or-else [block: block] {
  if not ($in | is-empty) {
    $in
  } else {
    do $block
  }
}

# If input is length-1, return the unwrapped element. Otherwise error.
export def unwrap-only [] {
  let head = ($in | and-then { take 2 })
  let n = ($head | length)
  if $n == 1 {
    $head | first
  } else if $n == 0 {
    error make {msg: $'get-only: input is empty'}
  } else {
    error make {msg: $'get-only: input has length > 1'}
  }
}