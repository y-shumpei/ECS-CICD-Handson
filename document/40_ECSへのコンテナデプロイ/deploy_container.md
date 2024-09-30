# ECSへのコンテナのデプロイ

デプロイしたECSにコンテナをデプロイを行うためのGitHub Actionsのワークフローを作成することが目標となります。

ワークフローの定義は`.github/workflow`配下のYAMLファイルで行います。  
ベースは作成済みですので一部値の設定をお願いします。

## 環境変数設定

Secretに下記の情報を登録

- `ECR_REPOSITORY`
- `ECS_CLUSTER`
- `ECS_SERVICE`
- `TASK_DEFINIION`
- `CONTAINER_NAME`

## GitHubActionsのワークフローファイルの編集

- ビルド
  - []

- デプロイ
  - [amazon-ecs-deploy-task-definition](https://github.com/aws-actions/amazon-ecs-deploy-task-definition)

メモ  
appspec.ymlにARNとか載ってるのよくない。

## コードをプッシュ

よしなにプッシュ  
やり方わからない人は下記参照

```bash
git add .
git commit -am "よしなに"
git push
```

## GitHubActionsの実行

よしなに

## Blue/Greenデプロイの確認

いらなそう。

## エンドポイントへのアクセス
