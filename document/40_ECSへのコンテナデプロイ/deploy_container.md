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

## 環境変数設定

各ファイルを確認して、環境変数を設定してください。

- `ECR_REPOSITORY`
- `ECS_CLUSTER`
- `ECS_SERVICE`
- `TASK_DEFINIION`
- `CONTAINER_NAME`
- `CODEDEPLOY_APPLICATION`
- `CODEDEPLOY_DEPLOYMENT_GROUP`

## GitHubActionsのワークフローファイルの編集

各ファイルの`###### ... ######`の項目に正しい処理を記載してください。  

## リンク

- ビルド
  - [docker/metadata-action](https://github.com/docker/metadata-action)
  - [docker build](https://docs.docker.jp/engine/reference/commandline/build.html)
  - [docker push](https://docs.docker.jp/engine/reference/commandline/push.html)
- デプロイ
  - [amazon-ecs-deploy-task-definition](https://github.com/aws-actions/amazon-ecs-deploy-task-definition)
