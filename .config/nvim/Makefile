autoload/plug.vim:
	curl --create-dirs -fLo $@ \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

.PHONY: vim-plug-update
vim-plug-update:
	rm -f autoload/plug.vim
	$(MAKE) autoload/plug.vim

.PHONY: update
update:
	nvim +PlugUpdate +quitall

.PHONY: clean
clean:
	rm -rf bundle/
