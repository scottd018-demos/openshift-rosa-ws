WS_USER ?= rosa-demo
database:
	aws dynamodb create-table \
		--table-name $(WS_USER)-microsweeper-scores \
		--attribute-definitions AttributeName=name,AttributeType=S \
		--key-schema AttributeName=name,KeyType=HASH \
		--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1

database-trust-policy:
	WS_USER=$(WS_USER) scripts/create-database-policy.sh

database-role:
	aws iam create-role --role-name $(WS_USER)_irsa --assume-role-policy-document file://trust-policy.json --description "$(WS_USER) IRSA Role" && \
	aws iam attach-role-policy --role-name $(WS_USER)_irsa --policy-arn=arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess

app-setup:
	oc new-project microsweeper-ex && \
	oc -n microsweeper-ex create serviceaccount microsweeper && \
	oc -n microsweeper-ex annotate serviceaccount microsweeper eks.amazonaws.com/role-arn=arn:aws:iam::`aws sts get-caller-identity --query 'Account' --output text`:role/$(WS_USER)_irsa

app:
	git clone https://github.com/rh-mobb/rosa-workshop-app.git && \
	WS_USER=$(WS_USER) scripts/create-app-properties.sh && \
	cd rosa-workshop-app && \
	quarkus build --no-tests
