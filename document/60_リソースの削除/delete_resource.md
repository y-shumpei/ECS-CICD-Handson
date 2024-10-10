# リソースの削除

## ハンズオンで利用したリソースの削除

ワークフロー `4 ハンズオン環境の削除`を実行してください。

## 開発環境の削除

### Cloud9の削除

1. Cloud9のコンソールから`ecs-cicd-handson-c9`を選択し、右上の`削除`を押して削除します。  
https://ap-northeast-1.console.aws.amazon.com/cloud9control/home?region=ap-northeast-1#/

### VPCの削除

1. VPCのコンソールから`ecs-cicd-handson-vpc`を選択し、右上の`アクション`から`VPCの削除`を押します。  
https://ap-northeast-1.console.aws.amazon.com/vpcconsole/home?region=ap-northeast-1#vpcs:

## 手順一覧

1. [開発環境の準備](./document/10_開発環境の準備/environment_preparation.md)
2. [OIDCの設定](./document/20_OIDCの設定/setting_OIDC.md)
3. [リソースのデプロイ](./document/30_リソースのデプロイ/deploy_resource.md)
4. [ECSへのコンテナデプロイ](./document/40_ECSへのコンテナデプロイ/deploy_container.md)
5. [セキュリティの実装](./document/50_セキュリティの実装/security_scan.md)
6. [リソースの削除](./document/60_リソースの削除/delete_resource.md)
