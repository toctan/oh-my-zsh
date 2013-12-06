_rbenv-installed() {
    hash rbenv 2>/dev/null
}

if _rbenv-installed ; then
    eval "$(rbenv init --no-rehash - zsh)"

    alias rubies="rbenv versions"
    alias gemsets="rbenv gemset list"
    alias gems="gem list"

    function current_ruby() {
        echo "$(rbenv version-name)"
    }

    function current_gemset() {
        echo "$(rbenv gemset active 2&>/dev/null | sed -e ":a" -e '$ s/\n/+/gp;N;b a' | head -n1)"
    }

    function rbenv_prompt_info() {
        if [[ -n $(current_gemset) ]] ; then
            echo "$(current_ruby)@$(current_gemset)"
        else
            echo "$(current_ruby)"
        fi
    }
fi
