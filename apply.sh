# git recent
git config --global alias.recent "!f() { \
  current=\$(git symbolic-ref --quiet --short HEAD); \
  git for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short)|%(committerdate:relative)|%(upstream:short)' | \
  while IFS='|' read -r branch last_commit upstream; do \
    if [ -n \"\$upstream\" ] && git show-ref --verify --quiet refs/remotes/\"\$upstream\"; then \
      upstream_display=\"\$upstream\"; \
    else \
      upstream_display=\"\"; \
    fi; \
    if [ \"\$branch\" = \"\$current\" ]; then branch=\"* \$branch\"; fi; \
    printf \"%-30s | %-15s | %s\n\" \"\$branch\" \"\$last_commit\" \"\$upstream_display\"; \
  done | (echo \"BRANCH                          | LAST COMMIT     | UPSTREAM\"; cat) | column -t -s '|' -o ' | '; \
}; f"
