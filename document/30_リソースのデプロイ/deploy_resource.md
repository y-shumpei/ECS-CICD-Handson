# リソースのデプロイ

GitHub Actionsを使って今回使用するリソースを作成します。  
下記構成が作成されます。  
![arch]( ./img/architecture.png)

## デプロイ用のポリシーの追加

ワークフローを実行するための権限をIAMロールに付与します。  
初めにIAMポリシーを作成します。

### IAMポリシーの作成

ポリシーは`AWS/iam_policy/cfn_deploy_policy.json`に用意しています。
このファイルを使用してポリシーを作成します。

```bash
aws iam create-policy --policy-name cfn-deploy-policy --policy-document file://AWS/iam_policy/cfn_deploy_policy.json
```

### IAMロールへアタッチ

続いて上記で作成したポリシーを`github-actions-role`にアタッチします。

```bash
aws iam attach-role-policy --role-name github-action-role --policy-arn arn:aws:iam::${AWS_ID}:policy/cfn-deploy-policy
```

## GitHub Actionsを流す

ロールの作成が完了したら、GitHub Actionsを実行します。

今回は`2 ハンズオン環境のデプロイ`というワークフローを使用します。  
先ほどと同じように、ワークフローを選択し`Run workflow`からワークフローを実行してください。
![run_workflow](./img/run_workflow.png)

成功したら、各種リソースを確認してみてください。
