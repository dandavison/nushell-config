export def merge-any [x2: any] {
    let x1 = $in
    if ($x1 | is-record) && ($x2 | is-record) {
        $x1 | merge-record $x2
    } else if ($x1 | is-list) && ($x2 | is-list) {
        $x1 | merge-list $x2
    } else {
        $x2
    }
}

export def merge-record [r2: record] {
    let r1 = $in
    if not ($r1 | is-record) {
        error make {msg: $'Not a record: ($r1)'}
    }
    if not ($r2 | is-record) {
        error make {msg: $'Not a record: ($r2)'}
    }
    let all_keys = (($r1 | record keys) | append ($r2 | record keys) | uniq)

    $all_keys | each { |k|
        let v1 = ($r1 | get -i $k)
        let v2 = ($r2 | get -i $k)
        let r1_has_k = $v1 != $nothing
        let r2_has_k = $v2 != $nothing
        if $r1_has_k && $r2_has_k {
            {$k: ($v1 | merge-any $v2)}
        } else if $r2_has_k {
            {$k: $v2}
        } else {
            $k: $v1
        }
    } | reduce {|a b| $a | merge {$b}}
}

export def merge-list [l2: list] {
    $in | append $l2 | uniq
}

def has [key: string] {
    ($in | get -i $key) != $nothing
}

def is-list [] {
  ($in | describe) | str starts-with 'list<'
}

def is-record [] {
  ($in | describe) | str starts-with 'record<'
}

export def 'record keys' [] {
    $in | transpose k v | get -i k
}
