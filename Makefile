env:
	virtualenv -p `which python2` env
	env/bin/pip install -r requirements.txt
	env/bin/pip install -r test-requirements.txt

build:
	docker build -t concourse-resource-gitlab-secret .

push:
	docker tag concourse-resource-gitlab-secret manulifeoss/concourse-resource-gitlab-secret:latest
	docker push manulifeoss/concourse-resource-gitlab-secret:latest

test:
	env/bin/pycodestyle assets/check assets/in
	env/bin/pylint assets/check assets/in
