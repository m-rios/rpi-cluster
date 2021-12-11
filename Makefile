.PHONY: bootstrap nomad format nas

fmt:
	prettier --write .

bootstrap:
	bootstrap/bin/bake

nomad:
	cd ansible; ansible-playbook playbooks/install_nomad.yaml

nas:
	cd ansible; ansible-playbook playbooks/nas.yaml
