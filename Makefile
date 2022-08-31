# Clean out team folders
clean:
	rm -r levelup/docker-volumes

env:
	aws cloudformation create-stack --stack-name coder-stack --template-body file://coder-workspaces.cfn.yml --parameters ParameterKey=InstanceType,ParameterValue=t3.xlarge > stack-id.json

env-test:
	aws cloudformation create-stack --stack-name coder-stack --template-body file://coder-workspaces.cfn.yml --parameters ParameterKey=InstanceType,ParameterValue=t2.micro ParameterKey=EnvironmentCount,ParameterValue=2 > test-stack-id.json

env-list:
	aws cloudformation describe-stacks --stack-name coder-stack

env-delete:
	aws cloudformation delete-stack --stack-name coder-stack

bootstrap:
	python3 -m pip install docker-compose

# set CODER_INSTANCE_COUNT= to the number of container to generate
compose:
	docker pull ghcr.io/jpwhite3/polyglot-code-server:latest
	python3 composer.py -n $(CODER_INSTANCE_COUNT)

start:
	docker-compose -f docker-compose.json up -d --remove-orphans

stop:
	docker-compose -f docker-compose.json stop
