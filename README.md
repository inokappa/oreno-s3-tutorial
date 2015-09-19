## S3 にファイルアップロードしてレスポンスとして URL を返すサンプル

### 準備

スクリプトをコンテナ化しているので以下のようにビルドする。

```sh
% docker build --no-cache=true -t upload-s3 .
```

### 使い方

- 普通のバケットにアップロード

```sh
docker run \
  --volume /path/to/host_dir:/path/to/container_dir \
  --env 'ACCESS_KEY_ID=AKXXXXXXXXXXXXXXXXXX' \
  --env 'SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
  --env 'AWS_REGION=ap-northeast-1' \
  --env 'S3_BUCKET=your-bucket' \
  --env 'FILE_NAME=/path/to/container_dir/file.png' \
upload-s3
```

output.

```sh
"https://your-bucket.s3-ap-northeast-1.amazonaws.com/file.png"
```

- Web ホスティングが有効なバケットにアップロード

```
Web ホスティングが有効なバケットにアップロード
docker run \
  --volume /path/to/host_dir:/path/to/container_dir \
  --env 'ACCESS_KEY_ID=AKXXXXXXXXXXXXXXXXXX' \
  --env 'SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
  --env 'AWS_REGION=ap-northeast-1' \
  --env 'S3_BUCKET=your-bucket.example.com' \
  --env 'VHOST=true' \
  --env 'FILE_NAME=/path/to/container_dir/file.png' \
upload-s3
```

output.

```sh
"https://your-bucket/file.png"
```
