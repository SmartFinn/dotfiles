PLUGINS_DIR ?= plugins

.PHONY: install
install: $(PLUGINS_DIR)/ranger-zoxide $(PLUGINS_DIR)/ranger_devicons

.PHONY: update
update:
	find "$(PLUGINS_DIR)" -type d -name '.git' -printf '%h\0' | \
		xargs -0 -I% git -C '%' pull

.PHONY: clean
clean:
	rm -rf $(PLUGINS_DIR)/

$(PLUGINS_DIR)/ranger-zoxide:
	git clone --depth 1 --filter=blob:none \
		https://github.com/jchook/ranger-zoxide.git $@

$(PLUGINS_DIR)/ranger_devicons:
	git clone --depth 1 --filter=blob:none \
		https://github.com/alexanderjeurissen/ranger_devicons.git $@
