_rbenv-installed() {
    hash rbenv 2>/dev/null
}

if _rbenv-installed ; then
    eval "$(rbenv init - --no-rehash)"

    alias rubies="rbenv versions"
    alias gemsets="rbenv gemset list"

    function current_ruby() {
        echo "$(rbenv version-name)"
    }

    function current_gemset() {
        echo "$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)"
    }

    function gems {
        local rbenv_path=$(rbenv prefix)
        gem list $@ | sed -E \
            -e "s/\([0-9a-z, \.]+( .+)?\)/$fg[blue]&$reset_color/g" \
            -e "s|$(echo $rbenv_path)|$fg[magenta]\$rbenv_path$reset_color|g" \
            -e "s/$current_ruby@global/$fg[yellow]&$reset_color/g" \
            -e "s/$current_ruby$current_gemset$/$fg[green]&$reset_color/g"
    }

    function rbenv_prompt_info() {
        if [[ -n $(current_gemset) ]] ; then
            echo "$(current_ruby)@$(current_gemset)"
        else
            echo "$(current_ruby)"
        fi
    }
fi
