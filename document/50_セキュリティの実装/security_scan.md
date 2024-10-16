# セキュリティの強化

ECSをデプロイする過程で、セキュリティリスクを発見し、セキュリティを強化することが目標になります。  
ネットで調べながら実装を進めてみてください。  
ヒントも活用してみるといいかもしれません。

## Trivyの実装

**Trivy**とはオープンソースのコンテナイメージスキャンツールです。  
コンテナイメージ内のパッケージやライブラリの脆弱性を検出します。  
公式ドキュメント：
<https://aquasecurity.github.io/trivy/v0.55/>

### ワークフローの実装

1. 以下条件を満たすTrivyのイメージスキャンを実装してください。  
ワークフローの実行は**イメージのビルド後**に実装してください。

- GitHub Actionsで用意されているTrivyを利用する
- `image-ref`は今回ビルドしたイメージを指定
- `format`は`table`で作成
- `severity`は`CRITICAL`と`HIGH`で作成
- `exit-code`は`1`で作成

2. コンテナが入れ替わっていることを確認するために、Dockerfileの中身を修正します。  
Dockerfileパス: `docker/ecs/Dockerfile`  
変更内容: `Hello Amazon ECS` -> `Trivy Success`

3. ワークフローが成功したら、以前の手順同様にコンテナの入れ替えを実施し、`Trivy Success`が表示されることを確認します。  

<details><summary>ヒント1</summary>

`run`を使ったコマンド実行ではなく、`uses`を使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認します。  
`Usage`の`Scan CI Pipeline`が参考になります。  
<https://github.com/aquasecurity/trivy-action>

</details>

<br>

<details><summary>ヒント3</summary>

実装するワークフローは以下です。
```
- name: Scan image with Trivy
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: ${{ steps.meta.outputs.tags }}
    format: "table"
    severity: "CRITICAL,HIGH"
    exit-code: 1
```
</details>

## Dockleの実装

**Dockle**はコンテナイメージのベストプラクティスに則っているかを検証します。  
公式ドキュメント：
<https://github.com/goodwithtech/dockle>

### ワークフローの実装

1. 以下条件を満たすTrivyのイメージスキャンを実装してください。  
ワークフローの実行は**Trivyの実行後**に実装してください。

- GitHub Actionsで用意されているDockleを利用する
- `image`は今回ビルドしたイメージを指定
- `failure-threshold`は`fatal`で作成
- `exit-code`は`1`で作成

2. コンテナが入れ替わっていることを確認するために、Dockerfileの中身を修正します。  
Dockerfileパス: `docker/ecs/Dockerfile`  
変更内容: `Trivy Success` -> `Dockle Success`

3. ワークフローが成功したら、以前の手順同様にコンテナの入れ替えを実施し、`Dockle Success`が表示されることを確認します。  

<details><summary>ヒント1</summary>

`run`を使ったコマンド実行ではなく、`uses`を使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認します。  
`Default settings against a public image`が参考になります。  
<https://github.com/erzz/dockle-action>

</details>

<br>

<details><summary>ヒント3</summary>

実装するワークフローは以下です。
```
- name: Check Docker best practices with Dockle
  uses: erzz/dockle-action@v1
  with:
    image: ${{ steps.meta.outputs.tags }}
    failure-threshold: fatal
    exit-code: 1
```
</details>

<br>

<details><summary>ヒント4</summary>

Actions中に発生したエラーを確認して、Dockerfileを修正してください。

</details>

<br>

<details><summary>ヒント5</summary>

エラー内容は以下です。
```
* Use 'rm -rf /var/lib/apt/lists' after 'apt-get install|update' : RUN /bin/sh -c apt-get update && apt-get install -y     curl     gnupg     ca-certificates     lsb-release # buildkit
* Use 'rm -rf /var/lib/apt/lists' after 'apt-get install|update' : RUN /bin/sh -c apt-get update && apt-get install -y nginx # buildkit
```
`apt-get`コマンド実行後に`rm -rf /var/lib/apt/lists`を実行するようにDockerfileを修正してください。
</details>

## 手順一覧

1. [開発環境の準備](../10_開発環境の準備/environment_preparation.md)
2. [OIDCの設定](../20_OIDCの設定/setting_OIDC.md)
3. [リソースのデプロイ](../30_リソースのデプロイ/deploy_resource.md)
4. [ECSへのコンテナデプロイ](../40_ECSへのコンテナデプロイ/deploy_container.md)
5. [セキュリティの実装](../50_セキュリティの実装/security_scan.md)
6. [リソースの削除](../60_リソースの削除/delete_resource.md)←次の手順です
