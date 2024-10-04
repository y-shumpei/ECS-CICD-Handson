# セキュリティの強化

ECSをデプロイする過程で、セキュリティリスクを発見し、セキュリティを強化することが目標になります。

## Trivyの実装

Trivyとはオープンソースのコンテナイメージスキャンツールです。  
コンテナイメージ内のパッケージやライブラリの脆弱性を検出します。  
公式ドキュメント：
<https://aquasecurity.github.io/trivy/v0.55/>

### ワークフローの実装

以下条件を満たすTrivyのイメージスキャンを実装してください。

1. GitHub Actionsで用意されているTrivyを利用する
2. formatはtableで作成
3. severityはCRITICALとHIGHで作成

<details><summary>ヒント1</summary>

runを使ったコマンド実行ではなく、usesを使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認する
<https://github.com/aquasecurity/trivy-action>

</details>

## Dockleの実装

Dockleはコンテナイメージのベストプラクティスに則っているかを検証します。  
公式ドキュメント：
<https://github.com/goodwithtech/dockle>

### ワークフローの実装

以下条件を満たすTrivyのイメージスキャンを実装してください。

1. GitHub Actionsで用意されているDockleを利用する

<details><summary>ヒント1</summary>

runを使ったコマンド実行ではなく、usesを使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認する
<https://github.com/goodwithtech/dockle-action>

</details>

<br>

<details><summary>ヒント3</summary>

Actions中に発生したエラーを確認して、Dockerfileを修正してください。

</details>

<br>

<details><summary>ヒント4</summary>

エラー内容は以下です
```
* Use 'rm -rf /var/lib/apt/lists' after 'apt-get install|update' : RUN /bin/sh -c apt-get update && apt-get install -y     curl     gnupg     ca-certificates     lsb-release # buildkit
* Use 'rm -rf /var/lib/apt/lists' after 'apt-get install|update' : RUN /bin/sh -c apt-get update && apt-get install -y nginx # buildkit
```
`apt-get`コマンド実行後に`rm -rf /var/lib/apt/lists`を実行するようにDockerfileを修正してください。
</details>