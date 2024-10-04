# 開発環境の準備

ソースコードの開発を進める環境を準備していきます。
VS Codeなどでローカルで開発できる環境がある方はそちらを利用しても問題ありません。

## 準備する環境

- githubアカウント
- gitとAWS CLIが利用できるIDE（VS Code、CLoud9など）  
以下コマンドで各バージョンが表示されるか確認してください
```
git --version
aws --version
```
- AWS Profile  
以下コマンドで`Account`のidと`Arn`が利用するアカウントid、利用するIAMユーザーのarnになっていることを確認してください
```
aws sts get-caller-identity
```

## 環境構築
### 1. Cloud9の作成

1. VPCを作成します。  
https://ap-northeast-1.console.aws.amazon.com/vpcconsole/home?region=ap-northeast-1#vpcs:
- 作成するリソースで`VPCなど`を選択
- 名前タグの自動生成に`ecs-cicd-handson`を入力
- それ以外はデフォルトで作成
![vpc](./img/vpc.png)

2. Cloud9を作成します。  
https://ap-northeast-1.console.aws.amazon.com/cloud9control/home?region=ap-northeast-1#/
- 名前に`ecs-cicd-handson-c9`を入力
- インスタンスタイプで`t3.small`を選択
- 接続で`セキュアシェル (SSH)`を選択
- VPCで`ecs-cicd-handson-vpc`を選択
- サブネットで任意のパブリックサブネットを選択
![cloud9_01](./img/cloud9_01.png)
![cloud9_02](./img/cloud9_02.png)

3. Cloud9に接続します。
`開く`を押して、Cloud9が開けることを確認します
![cloud9_03](./img/cloud9_03.png)

### 2. リポジトリをforkして、開発環境にcloneする

1. 以下リポジトリにアクセスして、右上の「**Fork**」を押します。  
https://github.com/CloudBuilders-Training/ECS-CICD-Handson

![fork_01](./img/fork_01.png)

2. `Owner`で「**自分のアカウント**」を指定して、「**Create fork**」を押します。

![fork_02](./img/fork_02.png)

3. 自分のアカウント配下にリポジトリをforkできたら、「**Code**」を押して、`HTTPS`のリンクをコピーします。

![clone_01](./img/clone_01.png)

4. 開発環境上で以下コマンドを実行します。
```
git clone https://github.com/[自分のgithubアカウント名]/ECS-CICD-Handson.git
```
すると以下のようCloud9上で`ECS-CICD-Handson`のフォルダが作成されます。

![clone_02](./img/clone_02.png)

### 3. AWS Profileの設定 ※CLoud9以外の利用者向け

terminalでAWS CLIを実行するAWS Profileの設定ができていない方は実施してください。

1. 自分のAWSアカウントにログインし、アクセスキーを発行するIAMユーザーを選択します  
https://us-east-1.console.aws.amazon.com/iam/home?region=ap-northeast-1#/users

2. 「**セキュリティ認証情報**」を選択し、「**アクセスキーを作成**」を押します。

3. 「**コマンドラインインターフェース（CLI）**」を選択し、確認事項にチェックを入れて「**次へ**」を押します。

4. 「**アクセスキーを作成**」を押します。

5. `アクセスキー`、`シークレットアクセスキー`が表示されるのでコピーし、「**.csvファイルをダウンロード**」を押して、「**完了**」を押します。

6. 開発環境のターミナルで以下コマンドを順次実行します。

AWS CLIをインストールしていない場合は、以下ドキュメントを参考にインストールしてください。  
https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/getting-started-install.html

- AWS Profile設定
```
aws configure --profile ecs-cicd-handson
```
設定値は以下です。
```
AWS Access Key ID [None]: 取得したアクセスキー
AWS Secret Access Key [None]: 取得したシークレットアクセスキー
Default region name [None]: ap-northeast-1
Default output format [None]: json
```
- AWS Profile切替
```
export AWS_PROFILE=ecs-cicd-handson
```

- AWS Profile設定確認
```
aws sts get-caller-identity
```
`Account`のidと`Arn`がアクセスキーを発行したユーザーのarnになっているか確認します。

以上で準備完了です。