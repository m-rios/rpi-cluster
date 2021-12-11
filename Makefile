.PHONY: all bootstrap nomad format nas

all: .hard_dependencies yarn.lock

fmt:
	prettier --write .

bootstrap:
	bootstrap/bin/bake

nomad:
	cd ansible
	ansible-playbook playbooks/install_nomad.yaml

nas:
	cd ansible
	ansible-playbook playbooks/nas.yaml

.soft_dependencies:
	echo installing yarn
	touch .yarn

# This should only run if package.json has been updated but yarn.lock hasn't
# but for some reson right now it runs every time
yarn.lock: package.json
ifeq (, $(shell which yarn))
	touch yarn.lock
else
	yarn install
endif

.hard_dependencies:
	# Use this to install all the hard dependencies
	echo installing dependencies
	touch .hard_dependencies
