# 開発環境の準備

ソースコードの開発を進める環境を準備していきます。
VS Codeなどでローカルで開発できる環境がある方はそちらを利用しても問題ありません。

## 前提条件

gitが利用できる

## Cloud9の作成

1. VPCを作成します
https://ap-northeast-1.console.aws.amazon.com/vpcconsole/home?region=ap-northeast-1#vpcs:
- 作成するリソースで`VPCなど`を選択
- 名前タグの自動生成に`ecs-cicd-handson`を入力
- それ以外はデフォルトで作成
![vpc](./img/vpc.png)

2. Cloud9を作成します
https://ap-northeast-1.console.aws.amazon.com/cloud9control/home?region=ap-northeast-1#/
- 名前に`ecs-cicd-handson-c9`を入力
- インスタンスタイプで`t3.small`を選択
- 接続で`セキュアシェル (SSH)`を選択
- VPCで`ecs-cicd-handson-vpc`を選択
- サブネットで任意のパブリックサブネットを選択
![cloud9_01](./img/cloud9_01.png)
![cloud9_02](./img/cloud9_02.png)

3. Cloud9に接続
`開く`を押して、Cloud9が開けることを確認します
![cloud9_03](./img/cloud9_03.png)