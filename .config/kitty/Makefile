PLUGINS_DIR ?= plugins

$(PLUGINS_DIR)/kitty_grab:
	git clone --depth 1 --filter=blob:none \
		https://github.com/yurikhan/kitty_grab.git $@

.PHONY: install
install: $(PLUGINS_DIR)/kitty_grab

.PHONY: update
update:
	find "$(PLUGINS_DIR)" -type d -name '.git' -printf '%h\0' | \
		xargs -0 -I% git -C '%' pull

.PHONY: clean
clean:
	rm -rf $(PLUGINS_DIR)/
