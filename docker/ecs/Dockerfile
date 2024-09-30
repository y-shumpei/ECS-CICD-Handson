# ベースイメージとしてUbuntu 22.04を使用
FROM ubuntu:22.04

# 環境変数を設定
ENV DEBIAN_FRONTEND=noninteractive

# パッケージリストを更新し、必要なパッケージをインストール
RUN apt-get update && apt-get install -y \
    curl \
    gnupg \
    ca-certificates \
    lsb-release

# Nginxの公式リポジトリを追加
RUN curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor \
    | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] \
    http://nginx.org/packages/mainline/ubuntu `lsb_release -cs` nginx" \
    | tee /etc/apt/sources.list.d/nginx.list

# Nginxをインストール
RUN apt-get update && apt-get install -y nginx

# indexファイルの作成
RUN echo 'Hello Amazon ECS' > /usr/share/nginx/html/index.html

# 80番ポートを開放
EXPOSE 80

# Nginxを起動
CMD ["nginx", "-g", "daemon off;"]