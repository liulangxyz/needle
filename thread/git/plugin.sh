# checkout bulk
git_discard() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done

  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 2); do
    rm -rf -- "$f"
  done
}

# display branch using fzf
fzf_git_branch() {
  git for-each-ref --format="%(refname:lstrip=2)" "refs/heads" | fzf -m
}

# checkout branch using fzf
fzf_git_checkout() {
  git checkout $(fgb)
}

# delete branch using fzf
fzf_git_branch_delete() {
  git branch -D $(fgb)
}