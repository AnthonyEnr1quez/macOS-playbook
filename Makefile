.PHONY: bootstrap_mac_untested
bootstrap_mac_untested: ## install pre-dependencies needed to install everything on mac
	#xcode-select --install
	#sudo xcodebuild -license
	pip install --upgrade pip
	pip install --ignore-installed ansible lxml
	ansible-galaxy install -r requirements.yml
	## todo setup pyenv before?

.PHONY: setup_requirements
setup_requirements:
	ansible-galaxy install -r requirements.yml

.PHONY: debug_main
debug_main:
	ansible-playbook -K main.yml -i inventory --ask-pass -v

.PHONY: zsh
zsh: 
	ansible-playbook -K main.yml --tags zsh -v

.PHONY: intellij
intellij: 
	ansible-playbook -K main.yml --tags intellij -i inventory --ask-pass -v