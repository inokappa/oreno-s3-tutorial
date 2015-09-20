## S3 にファイルアップロードしてレスポンスとして URL を返すサンプル

### 準備

スクリプトをコンテナ化しているので以下のようにビルドする。

```sh
% docker build --no-cache=true -t upload-s3 .
```

また、任意の S3 にオブジェクトをアップロード出来る権限を付与した IAM ユーザーを作成してアクセスキーとシークレットアクセスキーを取得しておく。

### Demo

- 普通のバケットにアップロード

```sh
docker run --rm \
  --env "TZ=Asia/Tokyo" \
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

- Web ホスティングが有効なバケットにアップロード（バケット名のみをドメイン名として返す）

```sh
docker run --rm \
  --env "TZ=Asia/Tokyo" \
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
"http://your-bucket/file.png"
```

- Presigned URL

```sh
docker run --rm \
  --env "TZ=Asia/Tokyo" \
  --volume /path/to/host_dir:/path/to/container_dir \
  --env 'ACCESS_KEY_ID=AKXXXXXXXXXXXXXXXXXX' \
  --env 'SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
  --env 'AWS_REGION=ap-northeast-1' \
  --env 'S3_BUCKET=your-bucket.example.com' \
  --env 'PRESIGN=true' \
  --env 'FILE_NAME=/path/to/container_dir/file.png' \
upload-s3
```

output.

```sh
"https://your-bucket.s3-ap-northeast-1.amazonaws.com/file.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKxxxxxxxxxxxxxxxxxxxx%2F20150919%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Date=20150919T134938Z&X-Amz-Expires=900&X-Amz-SignedHeaders=host&X-Amz-Signature=d4ffafd980868d63dd811ceb50fb17c4971b4e4c033c027106f2dc5dc67c9b4e"
```

- Presigned URL + Expire

```sh
docker run --rm \
  --env "TZ=Asia/Tokyo" \
  --volume /path/to/host_dir:/path/to/container_dir \
  --env 'ACCESS_KEY_ID=AKXXXXXXXXXXXXXXXXXX' \
  --env 'SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
  --env 'AWS_REGION=ap-northeast-1' \
  --env 'S3_BUCKET=your-bucket.example.com' \
  --env 'PRESIGN=true' \
  --env 'EXPIRE=300' \
  --env 'FILE_NAME=/path/to/container_dir/file.png' \
upload-s3
```

output.

```sh
"https://your-bucket.s3-ap-northeast-1.amazonaws.com/file.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKxxxxxxxxxxxxxxxxxxxx%2F20150919%2Fap-northeast-1%2Fs3%2Faws4_request&X-Amz-Date=20150919T134938Z&X-Amz-Expires=60&X-Amz-SignedHeaders=host&X-Amz-Signature=d4ffafd980868d63dd811ceb50fb17c4971b4e4c033c027106f2dc5dc67c9b4e"
```

