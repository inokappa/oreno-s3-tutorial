## S3 にファイルアップロードしてレスポンスとして URL を返すサンプル

### 使い方

```sh
# 普通のバケットにアップロード
docker run \
  --volume /path/to/host_dir:/path/to/container_dir \
  --env 'ACCESS_KEY_ID=AKXXXXXXXXXXXXXXXXXX' \
  --env 'SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx' \
  --env 'AWS_REGION=ap-northeast-1' \
  --env 'S3_BUCKET=your-bucket' \
  --env 'FILE_NAME=/path/to/container_dir/file.png' \
upload-s3

# Web ホスティングが有効なバケットにアップロード
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
