PLUGINS_DIR ?= plugins

$(PLUGINS_DIR)/tpm:
	git clone https://github.com/tmux-plugins/tpm $@

.PHONY: install
install:
	bash $(PLUGINS_DIR)/tpm/bindings/install_plugins

.PHONY: update
update:
	bash $(PLUGINS_DIR)/tpm/bindings/update_plugins

.PHONY: clean
clean:
	rm -rf $(PLUGINS_DIR)/
