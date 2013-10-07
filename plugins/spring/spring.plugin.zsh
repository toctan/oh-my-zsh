spring_commands=(testunit rspec cucumber rake rails)

## Functions

_spring-installed() {
    which spring > /dev/null 2>&1
}

_within-bundled-project() {
    local check_dir=$PWD
    while [ $check_dir != "/" ]; do
        [ -f "$check_dir/Gemfile" ] && return
        check_dir="$(dirname $check_dir)"
    done
    false
}

_run-with-spring() {
    if _spring-installed && _within-bundled-project; then
        spring $@
    else
        $@
    fi
}

## Main program
for cmd in $spring_commands; do
    eval "function nospring_$cmd () { $cmd \$@ }"
    eval "function spring_$cmd () { _run-with-spring $cmd \$@}"
    alias $cmd=spring_$cmd

    if which _$cmd > /dev/null 2>&1; then
        compdef _$cmd spring_$cmd=$cmd
    fi
done
