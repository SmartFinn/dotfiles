.PHONY: install
install:
	rm -f autoload/plug.vim doc/plug.txt
	$(MAKE) autoload/plug.vim doc/plug.txt
	vim +PlugInstall +quitall

autoload/plug.vim:
	curl --create-dirs -fLo $@ \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

doc/plug.txt:
	curl --create-dirs -fLo $@ \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/doc/plug.txt

.PHONY: update
update:
	vim +PlugUpdate +quitall

.PHONY: clean
clean:
	rm -rf bundle/
