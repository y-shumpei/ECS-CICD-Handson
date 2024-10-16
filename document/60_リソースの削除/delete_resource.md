# リソースの削除

## ハンズオンで利用したリソースの削除

ワークフロー `4 ハンズオン環境の削除`を実行してください。

## GitHubActions用ロールの削除

IAMポリシー `cfn-deploy-policy`および `deploy-ecs-task-policy`とIAMロール `github-actions-role`を削除します。

権限を付与し、下記シェルスクリプトを実行してください。

```bash
chmod 744 ./AWS/aws-cli/delete_role.sh
```

```bash
./AWS/aws-cli/delete_role.sh
```

## 開発環境の削除

### Cloud9の削除

1. Cloud9のコンソールから`ecs-cicd-handson-c9`を選択し、右上の`削除`を押して削除します。  
https://ap-northeast-1.console.aws.amazon.com/cloud9control/home?region=ap-northeast-1#/

### VPCの削除

1. VPCのコンソールから`ecs-cicd-handson-vpc`を選択し、右上の`アクション`から`VPCの削除`を押します。  
https://ap-northeast-1.console.aws.amazon.com/vpcconsole/home?region=ap-northeast-1#vpcs:

## 手順一覧

1. [開発環境の準備](../10_開発環境の準備/environment_preparation.md)
2. [OIDCの設定](../20_OIDCの設定/setting_OIDC.md)
3. [リソースのデプロイ](../30_リソースのデプロイ/deploy_resource.md)
4. [ECSへのコンテナデプロイ](../40_ECSへのコンテナデプロイ/deploy_container.md)
5. [セキュリティの実装](../50_セキュリティの実装/security_scan.md)
6. [**リソースの削除**](../60_リソースの削除/delete_resource.md)
