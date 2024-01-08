# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
# source ~/powerlevel10k/powerlevel10k.zsh-theme
# source ~/.oh-my-zsh/custom/themes/powerlevel10k/powerlevel10k.zsh-theme

ZSH_THEME="powerlevel10k/powerlevel10k"
# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

alias ll='lsd -lAt --group-dirs first' 
alias ls='lsd --group-dirs first' 
alias tree='lsd --tree --group-dirs first'
alias cls='clear'
alias python='python3'
alias pip='python3 -m pip'
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias nv='nvim .'
alias gtree='git log --oneline --all --graph --decorate'

export PYTHONPATH='$HOME/Documents/scripts/my_modules'
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$PATH:/Users/chema/.local/bin"
export PATH="$PATH:/Users/chema/go/bin"
export PATH="$PATH:/Users/chema/google-cloud-sdk/bin"
export PATH="$PATH:/Users/chema/rust-analyzer"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

export GONOSUMDB=gopkg.cabify.tools,gitlab.otters.xyz,secondary.gitlab.otters.xyz,gitlab.com/cabify,github.com/cabify
export GONOPROXY=gopkg.cabify.tools,gitlab.otters.xyz,secondary.gitlab.otters.xyz,gitlab.com/cabify,github.com/cabify
export GOPRIVATE=gopkg.cabify.tools,gitlab.otters.xyz,secondary.gitlab.otters.xyz,gitlab.com/cabify,github.com/cabify

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)

# opam configuration
[[ ! -r /Users/chema/.opam/opam-init/init.zsh ]] || source /Users/chema/.opam/opam-init/init.zsh  > /dev/null 2> /dev/null
eval $(opam env)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/chema/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/chema/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/chema/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/chema/google-cloud-sdk/completion.zsh.inc'; fi

# . $(brew --prefix asdf)/libexec/asdf.sh
. /opt/homebrew/opt/asdf/libexec/asdf.sh

# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib/c++ -Wl,-rpath,/opt/homebrew/opt/llvm/lib/c++"
# export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
# export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
