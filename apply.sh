# git recent
git config --global alias.recent "!f() { \
  current=\$(git symbolic-ref --quiet --short HEAD); \
  git for-each-ref --sort=-committerdate refs/heads/ \
    --format='%(refname:short)|%(committerdate:relative)|%(upstream:short)' | \
  awk -v curr=\"\$current\" -F'|' 'BEGIN {print \"BRANCH | LAST COMMIT | UPSTREAM\"} \
  { \
    branch=\$1; \
    if(branch == curr) branch=\"* \" branch; \
    printf \"%-30s | %-15s | %s\n\", branch, \$2, \$3; \
  }' | \
  column -t -s '|' -o ' | '; \
}; f"
