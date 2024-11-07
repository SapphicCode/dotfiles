alias gca  = git commit --amend
alias gcan = git commit --amend --no-edit
alias gp   = git push
alias gpf  = git push --force-with-lease

def "nix path" [...targets: string] list<string> {
    return (nix build --no-link --print-out-paths ...$targets | str trim | split row (char newline))
}
