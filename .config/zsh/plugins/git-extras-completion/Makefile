.PHONY: install
install: git-extras-completion.zsh git-extras-completion.plugin.zsh

git-extras-completion.zsh:
	curl -fLo $@ \
		https://raw.githubusercontent.com/tj/git-extras/master/etc/git-extras-completion.zsh

git-extras-completion.plugin.zsh:
	ln -sf git-extras-completion.zsh $@

.PHONY: update
update:
	rm -f git-extras-completion.zsh
	$(MAKE)

.PHONY: clean
clean:
	rm -f git-extras-completion.zsh
	rm -f git-extras-completion.plugin.zsh
