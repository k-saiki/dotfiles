.DEFAULT_GOAL := help

CURRENT_DIR  = $(shell pwd)
IGNORE_FILES = Makefile Brewfile

help: ## Print this message ## make help
	@echo "Usage: make SUB_COMMAND"
	@echo ""
	@echo "Command list:"
	@printf "\033[36m%-30s\033[0m %-50s %s\n" "[Sub command]" "[Description]" "[Example]"
	@grep -E '^[/a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | perl -pe 's%^([/a-zA-Z_-]+):.*?(##)%$$1 $$2%' | awk -F " *?## *?" '{printf "\033[36m%-30s\033[0m %-50s %s\n", $$1, $$2, $$3}'

setup-brew: ## Install Homebrew for Ubuntu ## make setup-brew
	@if [ -f /etc/lsb-release ] && !(type brew > /dev/null 2>&1); then \
		sudo apt install -y build-essential curl file git; \
		git clone https://github.com/Homebrew/brew ~/.linuxbrew/Homebrew; \
		mkdir ~/.linuxbrew/bin; \
		ln -s ~/.linuxbrew/Homebrew/bin/brew ~/.linuxbrew/bin; \
	fi

setup-vim: ## Install vim-plug ## make setup-vim
	@if [ ! -f ~/.vim/autoload/plug.vim ]; then \
		curl -fLo ~/.vim/autoload/plug.vim --create-dirs; \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim; \
	fi

setup-vscode: ## Install VSCode extensions ## make setup-vscode
	@if [ "" != `which code` ]; then \
		for extention in `cat $(CURRENT_DIR)/vscode/extensions`; do \
			code --install-extension $$extention; \
		done; \
	else \
		echo "Please install VSCode"; \
	fi

symlink: ## Install dotfiles to home directory ## make symlink
	@for file in `ls $(CURRENT_DIR)`; do \
		for ignore in $(IGNORE_FILES); do \
			if [ $$ignore = $$file ]; then \
				continue 3; \
			fi; \
		done; \
		echo "Create symlink: $(HOME)/.$$file"; \
		ln -sf $(CURRENT_DIR)/$$file $(HOME)/.$$file; \
	done

.PHONY: help setup-brew setup-vim setup-vscode symlink
