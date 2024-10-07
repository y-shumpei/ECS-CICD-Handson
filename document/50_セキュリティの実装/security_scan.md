# セキュリティの強化

ECSをデプロイする過程で、セキュリティリスクを発見し、セキュリティを強化することが目標になります。

## Trivyの実装

**Trivy**とはオープンソースのコンテナイメージスキャンツールです。  
コンテナイメージ内のパッケージやライブラリの脆弱性を検出します。  
公式ドキュメント：
<https://aquasecurity.github.io/trivy/v0.55/>

### ワークフローの実装

以下条件を満たすTrivyのイメージスキャンを実装してください。

1. GitHub Actionsで用意されているTrivyを利用する
2. formatはtableで作成
3. severityはCRITICALとHIGHで作成

<details><summary>ヒント1</summary>

`run`を使ったコマンド実行ではなく、`uses`を使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認します。
<https://github.com/aquasecurity/trivy-action>

</details>

<br>

<details><summary>ヒント3</summary>

実装するワークフローは以下です。
```
- name: Scan image with Trivy
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: ${{ inputs.ecr-repository-uri }}:${{ steps.tag.outputs.IMAGE_TAG }}
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

以下条件を満たすTrivyのイメージスキャンを実装してください。

1. GitHub Actionsで用意されているDockleを利用する

<details><summary>ヒント1</summary>

`run`を使ったコマンド実行ではなく、`uses`を使ったワークフローを実装します。

</details>

<br>

<details><summary>ヒント2</summary>

公式のリポジトリを確認します。
<https://github.com/goodwithtech/dockle-action>

</details>

<br>

<details><summary>ヒント3</summary>

実装するワークフローは以下です。
```
- name: Check Docker best practices with Dockle
  uses: erzz/dockle-action@v1
  with:
    image: ${{ inputs.ecr-repository-uri }}:${{ steps.tag.outputs.IMAGE_TAG }}
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