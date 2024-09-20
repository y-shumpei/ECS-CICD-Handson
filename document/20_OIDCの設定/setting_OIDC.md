# OIDCの設定

GitHub側からAWSのリソースにアクセスするための権限の設定を行います。  

## IDプロバイダの作成

```bash
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 1234567890123456789012345678901234567890
```

## IAMロールの作成

### 環境変数の設定

```bash
export GITHUB_REPOSITORY=$(git remote get-url origin|sed -E 's|^.*[:/]([^/]+/[^/]+)\.git$|\1|')
export PROVIDER_URL=token.actions.githubusercontent.com
export AWS_ID=$(aws sts get-caller-identity --query Account --output text)
export ROLE_NAME=github-actions
```

### 信頼関係ポリシーの作成

```bash
cat <<EOF > assume_role_policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "arn:aws:iam::${AWS_ID}:oidc-provider/${PROVIDER_URL}"
      },
      "Condition": {
        "StringLike": {
          "${PROVIDER_URL}:sub": "repo:${GITHUB_REPOSITORY}:*"
        }
      }
    }
  ]
}
EOF
```

### ロールの作成

```bash
aws iam create-role \
  --role-name $ROLE_NAME \
  --assume-role-policy-document file://assume_role_policy.json
```

## Secretの登録

## GitHubActionsの動作確認

レポジトリを開いて上部のタブからActionsを選択
