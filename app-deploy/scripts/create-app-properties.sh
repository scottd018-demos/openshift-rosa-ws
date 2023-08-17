cat <<EOF > ./rosa-workshop-app/src/main/resources/application.properties
# AWS DynamoDB configurations
%dev.quarkus.dynamodb.endpoint-override=http://localhost:8000
%prod.quarkus.openshift.env.vars.aws_region=us-east-1
%prod.quarkus.dynamodb.aws.credentials.type=default
dynamodb.table=${WS_USER}-microsweeper-scores

# OpenShift configurations
%prod.quarkus.kubernetes-client.trust-certs=true
%prod.quarkus.kubernetes.deploy=true
%prod.quarkus.kubernetes.deployment-target=openshift
%prod.quarkus.openshift.build-strategy=docker
%prod.quarkus.openshift.route.expose=true
%prod.quarkus.openshift.service-account=microsweeper

# To make Quarkus use Deployment instead of DeploymentConfig
%prod.quarkus.openshift.deployment-kind=Deployment
%prod.quarkus.container-image.group=microsweeper-ex
EOF