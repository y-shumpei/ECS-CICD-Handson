#!/bin/bash

ROLE_NAME="github-actions-role"

# IAMロールにアタッチされているポリシーのARNをリスト化する
POLICIES=$(aws iam list-attached-role-policies --role-name $ROLE_NAME --query "AttachedPolicies[*].PolicyArn" --output text)

# ポリシーを1つずつデタッチする
for POLICY_ARN in $POLICIES; do
    echo "Detaching policy: $POLICY_ARN from role: $ROLE_NAME"
    aws iam detach-role-policy --role-name $ROLE_NAME --policy-arn $POLICY_ARN
done

# ポリシー cfn-deploy-policy の削除
aws iam delete-policy --policy-arn $(
  aws iam list-policies \
    --query "Policies[?PolicyName=='cfn-deploy-policy'].{ARN:Arn}" \
    --output text
)

# ポリシー deploy_ecs_task_policy の削除
aws iam delete-policy --policy-arn $(
  aws iam list-policies \
    --query "Policies[?PolicyName=='deploy-ecs-task-policy'].{ARN:Arn}" \
    --output text
)

# ロールの削除
echo "Deleting role: $ROLE_NAME"
aws iam delete-role --role-name $ROLE_NAME
