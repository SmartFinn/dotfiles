CLONE_IGNORE ?=
CLONE_OPTS := $(foreach repo,$(CLONE_IGNORE),-i $(repo))

clone:
	@bash clone_gh_repos.sh $(CLONE_OPTS)

pull:
	@bash pull_repos.sh

prune:
	@bash prune.sh

maintenance:
	@bash run-maintenance.sh

.PHONY: clone pull prune
