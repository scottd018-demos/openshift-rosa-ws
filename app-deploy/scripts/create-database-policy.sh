cat <<EOF > ./trust-policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "Federated": "arn:aws:iam::$(aws sts get-caller-identity --query 'Account' --output text):oidc-provider/$(rosa describe cluster -c ${WS_USER/_/-} -o json | jq -r .aws.sts.oidc_endpoint_url | sed -e 's/^https:\/\///')" 
            },
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Condition": {
                "StringEquals": {
                    "$(rosa describe cluster -c ${WS_USER/_/-} -o json | jq -r .aws.sts.oidc_endpoint_url | sed -e 's/^https:\/\///'):sub": "system:serviceaccount:microsweeper-ex:microsweeper" 
                }
            }
        }
    ]
}
EOF