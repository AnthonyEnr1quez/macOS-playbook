.PHONY: bootstrap_mac_untested
bootstrap_mac_untested: ## install pre-dependencies needed to install everything on mac
	#xcode-select --install
	#sudo xcodebuild -license
	bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew list pyenv || brew install pyenv

	$(eval python_version := $(shell pyenv install --list | grep --extended-regexp "^\s*[0-9][0-9.]*[0-9]\s*$$" | tail -1))
	@echo $(python_version)
	pyenv versions | [[ $$(< /dev/stdin) =~ $(python_version) ]] || pyenv install $(python_version)
	pyenv global $(python_version)
	
	pip install --upgrade pip
	pip install --ignore-installed ansible lxml
	make ansible_requirements

.PHONY: ansible_requirements
ansible_requirements:
	ansible-galaxy install -r requirements.yml

playbook_base= ansible-playbook -K main.yml

.PHONY: main
debug_main:
	ansible-playbook -K main.yml -i inventory --ask-pass -v

.PHONY: homebrew
homebrew: 
	ansible-playbook -K main.yml --tags homebrew -i inventory --ask-pass -v

.PHONY: zsh
zsh: 
	ansible-playbook -K main.yml --tags zsh -v

.PHONY: dotfiles
dotfiles: 
	ansible-playbook -K main.yml --tags dotfiles -v

.PHONY: intellij
intellij: 
	ansible-playbook -K main.yml --tags intellij -i inventory --ask-pass -v

.PHONY: dock
dock:
	ansible-playbook -K main.yml --tags dock -i inventory --ask-pass -v

.PHONY: remote_sdks
remote_sdks:
	ansible-playbook -K main.yml --tags sdks -i inventory --ask-pass -v

.PHONY: local_dock
local_dock:
	ansible-playbook -K main.yml --tags dock -v
