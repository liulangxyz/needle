# checkout all modified files at one go
git_checkout() {
  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 3); do
    git checkout -- "$f"
  done

  for f in $(git status -s | grep -E -v "\?\?" | cut -d ' ' -f 2); do
    rm -rf -- "$f"
  done
}

# display branch using fzf
fgb() {
  git for-each-ref --format="%(refname:lstrip=2)" "refs/heads" | fzf
}

# checkout branch using fzf
fgc() {
  git checkout $(fgb)
}

# delete branch using fzf
fgbd() {
  git branch -D $(fgb)
}