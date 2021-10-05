.PHONY: bootstrap_mac_untested
bootstrap_mac_untested: ## install pre-dependencies needed to install everything on mac
	#xcode-select --install
	#sudo xcodebuild -license
	which brew || bash -c "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

playbook_base= ansible-playbook -K main.yml -i inventory.yml -v

.PHONY: mojave
mojave:
	$(playbook_base) --limit mojave --ask-pass $(optional_tags)

.PHONY: local
local:
	$(playbook_base) --limit local $(optional_tags)

.PHONY: tags
tags:
	make $(host) optional_tags="--tags $(tags)"

.PHONY: homebrew
homebrew: 
	make tags host=$(host) tags=homebrew

.PHONY: zsh
zsh: 
	make tags host=$(host) tags=zsh

.PHONY: dotfiles
dotfiles: 
	make tags host=$(host) tags=dotfiles

.PHONY: intellij
intellij: 
	make tags host=$(host) tags=intellij

.PHONY: dock
dock:
	make tags host=$(host) tags=dock

.PHONY: sdks
sdks:
	make tags host=$(host) tags=sdks
