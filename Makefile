ifndef MLIFE_VERSION
$(error MLIFE_VERSION is not set)
endif

all: release

release: validate
	@echo "Inside release"
	#sudo apt-get -y install python3 python3-pip
	python3 -m pip install semver
	python3 checkVersion.py ${MLIFE_VERSION}
	@echo Releasing ${MLIFE_VERSION}
	git stash
	git checkout main
	git reset --hard HEAD
	git tag env.${MLIFE_ENV} --force
	git push --tags --force

validate:
	@echo Validating config files using Kubeval.
	kubeval -d .
	@echo Identifying misconfigurations/best practices in Kubernetes objects using kube-linter. 
	#kube-linter lint .