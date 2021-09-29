.PHONY: bootstrap_mac_untested
bootstrap_mac_untested: ## install pre-dependencies needed to install everything on mac
	xcode-select --install
	sudo xcodebuild -license
	sudo pip3 install --upgrade pip
	pip3 install --ignore-installed ansible
	ansible-galaxy install -r requirements.yml
	pip3 install --ignore-installed lxml
	## PIP_REQUIRE_VIRTUALENV=false pip install -U -r requirements.txt
	## pipx install ansible
	## ansible-galaxy install -r requirements.yml

.PHONY: setup_requirements
setup_requirements:
	ansible-galaxy install -r requirements.yml

.PHONY: debug_main
debug_main:
	ansible-playbook -K main.yml -i inventory --ask-pass -v

.PHONY: zsh
zsh: 
	ansible-playbook -K main.yml --tags zsh -i inventory --ask-pass -v

.PHONY: intellij
intellij: 
	ansible-playbook -K main.yml --tags intellij -i inventory --ask-pass -v