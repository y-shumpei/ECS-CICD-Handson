# ECSへのコンテナのデプロイ

デプロイしたECSにコンテナをデプロイを行うためのGitHub Actionsのワークフローを作成することが目標となります。

はじめにワークフローを実行するためのポリシーをロールに付与します。

## IAMポリシーの作成

ポリシーは`AWS/iam_policy/deploy_ecs_task_policy.json`に用意しています。
このファイルを使用してポリシーを作成します。

```bash
aws iam create-policy --policy-name deploy-ecs_task_policy --policy-document file://AWS/iam_policy/deploy_ecs_task_policy.json
```

## IAMロールへアタッチ

続いて上記で作成したポリシーを`github-actions-role`にアタッチします。

```bash
aws iam attach-role-policy --role-name github-action-role --policy-arn arn:aws:iam::${AWS_ID}:policy/deploy_ecs_task_policy
```

## ワークフローファイルの作成

ここから皆さんに色々調べてもらいながらファイルを作成します。

予め、ワークフローのファイルは用意しており今回はその中のファイルを編集してワークフローを完成させていただきます。  
今回使用するファイルは、下記の3ファイルになります。各ファイルを開いてみてください。  

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

まず、`.github/workflows/30_ecs-task-deploy.yml`についてです。こちらのファイルは`.github/workflow`配下のファイルとなるので、ワークフローはこちらから実行されます。そのため、ワークフローの全体の流れを定義しているファイルとなります。  

ここで着目していただきたい記載が24行目と30行目になります。

【24行目】

```yaml
- uses: ./.github/actions/container-build/
```

【30行目】

```yaml
- uses: ./.github/actions/container-deploy/
```

それぞれ、カレントディレクトリから今回扱う残りの2ファイルへのパスとなっています。  
これらは残りの2ファイルで定義されたタスクを呼び出しています。

24行目にて呼び出している`.github/workflows/container-build/action.yml`では、コンテナのビルドを行い、ECRにプッシュします。

30行目にて呼び出している`.github/workflows/contianer-deploy/action.yml`では、ECRのリポジトリからECSのタスク定義を更新し、ECSクラスターのサービスを更新しています。

ファイルの説明としては、以上となります。  
ここからは実際に先ほどデプロイしたリソースから必要な変数を設定したり、ワークフローファイルを編集していただきます。

### リポジトリ変数設定

`.github/workflows/30_ecs-task-deploy.yml`のステップ内の各タスクにて`with`という要素があります。  
こちらでは、タスクに対して変数を与えることができます。

例えば、下記のような記載があります。

【26~27行目】

```yaml
with:
  ecr-repository-uri: ${{ secrets.ECR_REPOSITORY_URL }}
```

`${{ secrets.ECR_REPOSITORY_URL }}` という記載では`Secret`に`ECR_REPOSITORY_URL`という名前で登録された値を参照しています。

OIDCの設定の際に登録したように、ワークフロー内で参照するための変数の設定を行ってください。  
対象となる変数名は下記になります。

- `ECR_REPOSITORY`：ECRのリポジトリ名のみの値になります。
- `ECS_CLUSTER`：ECSクラスターの名前になります。
- `ECS_SERVICE`：ECSサービスの名前になります。上記のECSクラスター内にて確認できます。
- `TASK_DEFINIION`：タスク定義の名前になります。ECSのマネジメントコンソール上にて確認できます。
- `CONTAINER_NAME`：上記のタスク定義内にあるコンテナ名になります。
- `CODEDEPLOY_APPLICATION`：CodeDeployのアプリケーションの名前になります。
- `CODEDEPLOY_DEPLOYMENT_GROUP`：上記アプリケーション内にあるデプロイグループの名前になります。

### GitHubActionsのワークフローファイルの編集

各ファイルの`###### ... ######`の項目に正しい処理を記載してください。  

### 参考リンク

- ビルド
  - [docker/metadata-action](https://github.com/docker/metadata-action)
  - [docker build](https://docs.docker.jp/engine/reference/commandline/build.html)
  - [docker push](https://docs.docker.jp/engine/reference/commandline/push.html)
- デプロイ
  - [amazon-ecs-deploy-task-definition](https://github.com/aws-actions/amazon-ecs-deploy-task-definition)
