autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

zmodload -i zsh/parameter
insert-last-command-output() {
LBUFFER+="$(eval $history[$((HISTCMD-1))])"
}
zle -N insert-last-command-output
bindkey '\C-x\C-i' insert-last-command-output
