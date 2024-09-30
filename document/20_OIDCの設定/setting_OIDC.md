# OIDCの設定

GitHub側からAWSのリソースにアクセスするための権限の設定を行います。  

## IDプロバイダの作成

OpenID Connect Providrを作成し、AWSがGitHub OIDC Providerを信頼するように設定を行います。  
下記コマンドを実行してください。

```bash
aws iam create-open-id-connect-provider \
  --url https://token.actions.githubusercontent.com \
  --client-id-list sts.amazonaws.com \
  --thumbprint-list 1234567890123456789012345678901234567890
```

## IAMロールの作成

GitHubがAWSリソースにアクセスする際に使用するロールを作成します。

### 変数の設定

後の信頼関係ポリシーの作成のためリポジトリ名とアカウントIDを変数に設定します。  

```bash
export GITHUB_REPOSITORY=$(git remote get-url origin|sed -E 's|^.*[:/]([^/]+/[^/]+)\.git$|\1|')
export AWS_ID=$(aws sts get-caller-identity --query Account --output text)
```

### 信頼関係ポリシーの作成

信頼関係ポリシーを作成します。  

```bash
cat <<EOF > assume_role_policy.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Principal": {
        "Federated": "arn:aws:iam::${AWS_ID}:oidc-provider/token.actions.githubusercontent.com"
      },
      "Condition": {
        "StringLike": {
          "token.actions.githubusercontent.com:sub": "repo:${GITHUB_REPOSITORY}:*"
        }
      }
    }
  ]
}
EOF
```

### ロールの作成

`github-actions-role`という名前でロールを作成します。  

```bash
aws iam create-role \
  --role-name github-actions-role \
  --assume-role-policy-document file://assume_role_policy.json
```

ロールの作成が完了したらAWS側での準備は終了です。

## Secretの登録

GitHub Actionを実行するためには、`.github/workflow`配下にワークフローの設定ファイルを設置する必要があります。  
この配下のファイルにGitHub Actionsで実行したい処理を書いていきますが例えばAPIキーなどといった機密情報をファイルの中で扱うこともあります。
そうした情報は`Secret`に保存することで外部に公開することを防ぐことができます。  

`Secret`に保存することにより、値は暗号化して管理され保存後、値を確認することができなくなります。
また、**GitHub Actions実行時のログ出力時にも値がマスク**されるので情報を安全に扱うことができます。

`.github/workflow/OIDC-test.yml`を開いて見てください。4行目に次のような記述があります。

```text
ROLE_ARN: arn:aws:iam::${{ secrets.AWS_ID }}:role/${{ secrets.ROLE_NAME }}
```

`Secret`に保存した情報は`${{ secrets.変数名 }}`といった形式で参照することができます。
ここでは、AWSのアカウントIDとロール名を`Secret`から参照しています。  

この2つの情報を`Secret`に保存します。

1. ブラウザ上でリポジトリを開き、上側のタブから`Setting`を画面が遷移したら左のタブから`Secrets and variables`→`Actions`を選択します。
![secret](./img/secret.png)

2. 下記画面が開けたら、`New repository secret`を押下します。
![new_repository_secret](./img/new_repository_secret.png)

3. `Name`に`ROLE_NAME`、`Secret`に`github-actions-role`と入力して`Add secret`を押下してください。
これで、ロール名は保存完了です。
![new_secret](./img/new_secret.png)

4. 同様に`AWS_ID`という名前でアカウントIDを保存してください。

## GitHubActionsの動作確認

レポジトリを開いて上部のタブからActionsを選択
