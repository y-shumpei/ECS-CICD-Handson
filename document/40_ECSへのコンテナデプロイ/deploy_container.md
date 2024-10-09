# ECSへのコンテナのデプロイ

デプロイしたECSにコンテナをデプロイを行うためのGitHub Actionsのワークフローを作成することが目標となります。

今回使用するファイルは、下記になります。

```text
.github
├── actions
│   ├── container-build
│   │   └── action.yml
│   └── container-deploy
│       └── action.yml
└── workflows
    └── 30_ecs-task-deploy.yml
```

`actions`配下のファイルでは、コンテナのビルド・プッシュとタスクのデプロイの処理をそれぞれ分けて定義しています。
[メタデータ構文](https://docs.github.com/ja/actions/sharing-automations/creating-actions/metadata-syntax-for-github-actions)といいます。

はじめにワークフローを実行するためのポリシーをロールに付与します。

## IAMポリシーの作成

ポリシーは`AWS/iam_policy/deploy_ecs_task_policy.json`に用意しています。
このファイルを使用してポリシーを作成します。

```bash
aws iam create-policy --policy-name deploy-ecs-task-policy --policy-document file://AWS/iam_policy/deploy_ecs_task_policy.json
```

## IAMロールへアタッチ

続いて上記で作成したポリシーを`github-actions-role`にアタッチします。

```bash
aws iam attach-role-policy --role-name github-actions-role --policy-arn arn:aws:iam::${AWS_ID}:policy/deploy-ecs-task-policy
```

## 環境変数設定

GitHub上で、以下環境変数を設定してください。  
各値はコンソールから確認してください。

- `Secrets`に登録
  - `ECR_REPOSITORY_URL` - ECRリポジトリURL
- `Variables`に登録
  - `ECR_REPOSITORY` - ECRリポジトリ名
  - `ECS_CLUSTER_NAME` - ECSクラスター名
  - `ECS_SERVICE_NAME` - ECRサービス名
  - `TASK_DEFINITION_NAME` - タスク定義名
  - `CONTAINER_NAME` - コンテナ名
  - `CODEDEPLOY_APPLICATION` - CodeDeployアプリケーション名
  - `CODEDEPLOY_DEPLOYMENT_GROUP` - CodeDeployデプロイメントグループ名

## GitHubActionsのワークフローファイルの編集

以下ファイルの`###### ... ######`の項目に正しい処理を記載してください。  
- .github/actions/container-build/action.yml
- .github/actions/container-deploy/action.yml
- .github/workflows/30_ecs-task-deploy.yml
ファイルの修正が完了したら、以下コマンドを順次実行して、リポジトリにpushしてください。  
コミットメッセージにはコードの修正内容がわかるようなメッセージを記載してください。  
```
git add .
git commit -m "コミットメッセージ"
git push -u origin main
```
pushをトリガーに`ECS タスクデプロイ`のworkflowが起動します。  
失敗したら内容を確認し、修正して再度pushしてください。

<details><summary>ヒント1</summary>

dockerのビルドコマンドは以下です。  
<dockerファイルのパス>と<タグ>をそれぞれ書き換えてください。
```
docker build -f <dockerファイルのパス> -t <タグ> .
```

</details>

<br>

<details><summary>ヒント2</summary>

dockerのプッシュコマンドは以下です。
<タグ>を書き換えてください。
```
docker push <タグ>
```

</details>

<br>

<details><summary>ヒント3</summary>

`.github/workflows/30_ecs-task-deploy.yml`の`container-image`のように、以前の処理で出力した内容を利用することができます。

</details>

## CodeDeployを実行してタスクを入れ替える

1. GitHub Actionsが正常に終了すると、CodeDeployが実行されるので、`CodeDeploy` -> `デプロイメント` -> `進行中のデプロイ`を押して確認します。  
![code_deploy_01](./img/code_deploy_01.png)

2. ステップ3まで進むと、置き換えタスクセットが作成されるので、ALBの8080ポートにアクセスして、正常に閲覧できるかを確認します。  
**Hello Amazon ECS**が画面に表示されていれば成功です。

3. 右上の`トラフィックを再ルーティング`を押して、タスクセットの切り替えを実施します。
![code_deploy_02](./img/code_deploy_02.png)

4. ステップ5まで進んだら`元のタスクセットの終了`を押します。
![code_deploy_03](./img/code_deploy_03.png)

5. ALBの80ポートにアクセスして置き換えが完了していることを確認します。  
**Hello Amazon ECS**が画面に表示されていれば成功です。

## リンク

- ビルド
  - [docker/metadata-action](https://github.com/docker/metadata-action)
  - [docker build](https://docs.docker.jp/engine/reference/commandline/build.html)
  - [docker push](https://docs.docker.jp/engine/reference/commandline/push.html)
- デプロイ
  - [amazon-ecs-deploy-task-definition](https://github.com/aws-actions/amazon-ecs-deploy-task-definition)
