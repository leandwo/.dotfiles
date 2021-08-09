# TODO:
# - Set variables
# - Create aliases
# - Customize the prompt
# - Write handy functions
# - Change ZSH options
# - Adjust history functionality
# - Improve line editor (completions, menu, navigation, etc.)
# - Add locations to $PATH variable (or $path array)
# - Use ZSH plugins
# - Change key bindings
# - Add "zstyles" for completions & more
#

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/leosol/.oh-my-zsh"

# powerlevel10k oh-my-zsh
source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme


# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme

###########
# ALIASES #
###########

alias l="exa -abhHlS"

# folders
alias dev="cd ~/m/dev/"
alias config="cd ~/.config/"
alias temp="cd ~/tmp/"
alias tmp="cd ~/tmp/"
alias dotfiles="cd ~/.dotfiles/"
alias df="dotfiles"
alias leetcode="cd ~/m/dev/leetcode/"
alias lc="leetcode"

# config files
alias zshrc="df && nvim zshrc"
alias z="zshrc"
alias yabairc="df && nvim yabairc"
alias yrc="yabairc"
alias skhdrc="df && nvim skhdrc"
alias skhd="skhdrc"
alias vimrc="df && v init.vim"
alias iv="vimrc"
alias spacebarrc="df && nvim spacebarrc"
alias qb="df && v qutebrowser/config.py"
alias kconf="df && v kitty/kitty.conf"
alias k="kconf"


# work folders
alias fs-ios="cd ~/m/dev/fs-ios"
alias fs-dash="cd ~/m/dev/fs-dash && gcloud config configurations activate fsa && pipenv shell"
alias fs-www="fs-dash"
alias fs-api="cd ~/m/dev/fs-api"
alias scs-old="cd ~/m/dev/scs-old && gcloud config configurations activate scs && pipenv shell"
alias scs-api="cd ~/m/dev/scs-api"
alias scs-next="cd ~/m/dev/scs-www"
alias scs-www="scs-next"
alias scs-tools="cd ~/m/dev/scs-tools"
alias cj="cd ~/m/dev/cj"
alias cj_cloud_functions="cd ~/m/dev/cj/web/api/cart"
alias cjcf="cj_cloud_functions"

# restart brew services
alias restart_yabai="brew services restart yabai"
alias ry="restart_yabai"
alias restart_spacebar="brew services restart spacebar"
alias rsp="restart_spacebar"

# keyboards keyboards
alias flash-zygote="qmk flash -kb zygote -km leosolid"
alias flash-technik="qmk flash -kb boardsource/technik_o -km leosolid"
alias edit-zygote="nvim ~/m/dev/qmk_firmware/keyboards/zygote/keymaps/leosolid/keymap.c"
alias edit-technik="cd ~/m/dev/qmk_firmware/keyboards/boardsource/technik_o/keymaps/leosolid/ && nvim ~/m/dev/qmk_firmware/keyboards/boardsource/technik_o/keymaps/leosolid/keymap.c"

# github
alias gh_web="gh repo view --web"
alias ghw="gh_web"

# vim 
alias v="nvim"
alias vg="nvim +:Git +:only"
alias ww="nvim -c ':VimwikiIndex'"
alias w="nvim -c ':VimwikiIndex'"
alias wi="nvim -c ':VimwikiDiaryIndex'"
alias wt="nvim -c ':VimwikiMakeDiaryNote'"
alias wy="nvim -c ':VimwikiMakeYesterdayDiaryNote'"
alias wm="nvim -c ':VimwikiMakeTomorrowDiaryNote'"

# man
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# calendar.vim
alias calendar="nvim -c ':Calendar'"
alias cal="calendar"
alias c="calendar"

# task, taskwarrior
alias t="task"
alias ta="task add"
alias tn="task next"
alias tw="task next pro:work"
alias i="task add +in"
alias ti="task in"
tickle () {
  deadline=$1
  shift
  i +tickle wait:$deadline $@
}
alias tick=tickle
alias think='tickle +1d'
webpage_title (){
  wget -qO- "$*" | hxselect -s '\n' -c  'title' 2>/dev/null
}
read_and_review (){
  link="$1"
  title=$(wget -qO- $link | perl -l -0777 -ne 'print $1 if /<title.*?>\s*(.*?)\s*<\/title/si')
  echo $title
  descr="\"Read and review: $title\""
  id=$(task add +next +rnr "$descr" | sed -n 's/Created task \(.*\)./\1/p')
  task "$id" annotate "$link"
}
alias rnr=read_and_review

# python
alias py='python3'
alias py2='python'

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/leosol/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/leosol/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/leosol/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/leosol/google-cloud-sdk/completion.zsh.inc'; fi

export EDITOR=/usr/local/bin/nvim
export GIT_EDITOR=/usr/local/bin/nvim

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/local/Caskroom/miniconda/base/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh" ]; then
        . "/usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh"
    else
        export PATH="/usr/local/Caskroom/miniconda/base/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

