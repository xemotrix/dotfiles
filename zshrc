# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"
# ZSH_THEME=""
# source /usr/local/opt/powerlevel10k/powerlevel10k.zsh-theme
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

alias nvim="~/nvim-macos/bin/nvim"
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
export PATH="/opt/homebrew/opt/llvm@13/bin:$PATH"
export PATH="$HOME/.cabal/bin:$PATH"
export PATH="$HOME/.elan/bin:$PATH"
export PATH="$HOME/Library/Application Support/Coursier/bin:$PATH"

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

export PKG_CONFIG_PATH="$PKG_CONFIG_PATH:/opt/homebrew/lib/pkgconfig/"

export LDFLAGS="-L/opt/homebrew/opt/llvm@13/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm@13/include"

export PATH="/opt/homebrew/opt/icu4c/bin:$PATH"
