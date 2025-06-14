# n8n Docker Compose 設定

このファイルは n8n（自動化・ワークフロー管理ツール）の Docker Compose 設定です。

## 構成

- **n8n**: メインアプリケーション（ポート: 5678）
- **n8n-webhook**: Webhook 専用インスタンス（ポート: 5679）
- **n8n-worker**: バックグラウンドタスク処理
- **n8n-postgres**: PostgreSQL データベース（ポート: 5433）
- **n8n-redis**: Redis キャッシュ・キューシステム（ポート: 6380）
- **n8n-nginx**: リバースプロキシ（ポート: 8080, 8443）

## セットアップ

### 1. 必要なディレクトリの作成

```bash
sudo mkdir -p /DATA/AppData/n8n/{postgres,redis,data,files,nginx,ssl}
sudo chown -R $USER:$USER /DATA/AppData/n8n
```

### 2. nginx 設定ファイルの配置

`n8n-nginx.conf`の内容を`/DATA/AppData/n8n/nginx/default.conf`にコピーしてください。

### 3. 起動

```bash
docker-compose -f n8n.yml up -d
```

### 4. 確認

```bash
docker-compose -f n8n.yml ps
```

## アクセス

- **メインアプリケーション**: http://localhost:8080
- **直接アクセス**: http://localhost:5678
- **Webhook URL**: http://localhost:5679

## デフォルトログイン情報

- **ユーザー名**: admin
- **パスワード**: admin123

⚠️ **セキュリティ**: 本番環境では必ず変更してください！

## セキュリティ設定

### 1. パスワードの変更

n8n.yml ファイル内の以下の値を変更：

```yaml
- N8N_BASIC_AUTH_USER=admin
- N8N_BASIC_AUTH_PASSWORD=admin123
- DB_POSTGRESDB_PASSWORD=n8npassword
- QUEUE_BULL_REDIS_PASSWORD=n8nredispassword
- N8N_ENCRYPTION_KEY=n8n-encryption-key-change-this
```

### 2. SSL/TLS 設定

SSL 証明書がある場合：

1. 証明書を`/DATA/AppData/n8n/ssl/`に配置
2. nginx 設定ファイル内の SSL 関連行のコメントを解除
3. HTTP 部分をコメントアウト

## 環境変数の説明

### n8n メイン設定

- `N8N_BASIC_AUTH_ACTIVE`: 基本認証の有効化
- `DB_TYPE`: データベースタイプ（postgresdb）
- `QUEUE_BULL_REDIS_HOST`: Redis ホスト
- `N8N_ENCRYPTION_KEY`: データ暗号化キー
- `WEBHOOK_URL`: Webhook のベース URL
- `GENERIC_TIMEZONE`: タイムゾーン設定

### 実行設定

- `EXECUTIONS_MODE`: 実行モード（regular/queue）
- `EXECUTIONS_TIMEOUT`: 実行タイムアウト（秒）
- `EXECUTIONS_DATA_SAVE_ON_ERROR`: エラー時のデータ保存
- `EXECUTIONS_DATA_PRUNE`: 古い実行データの削除

## 運用

### ログの確認

```bash
docker-compose -f n8n.yml logs -f n8n
```

### バックアップ

```bash
# データベースバックアップ
docker exec n8n-postgres pg_dump -U n8n n8n > n8n_backup.sql

# データディレクトリバックアップ
sudo tar -czf n8n_data_backup.tar.gz /DATA/AppData/n8n/data
```

### 復元

```bash
# データベース復元
cat n8n_backup.sql | docker exec -i n8n-postgres psql -U n8n -d n8n

# データディレクトリ復元
sudo tar -xzf n8n_data_backup.tar.gz -C /
```

### 停止・削除

```bash
# 停止
docker-compose -f n8n.yml down

# データも含めて完全削除
docker-compose -f n8n.yml down -v
sudo rm -rf /DATA/AppData/n8n
```

## トラブルシューティング

### 1. データベース接続エラー

- PostgreSQL コンテナが起動しているか確認
- データベース認証情報が正しいか確認

### 2. Redis エラー

- Redis コンテナが起動しているか確認
- Redis 認証情報が正しいか確認

### 3. 権限エラー

```bash
sudo chown -R $USER:$USER /DATA/AppData/n8n
```

### 4. ポート競合

- 使用ポート（5678, 5679, 5433, 6380, 8080）が他のサービスで使用されていないか確認

## ワークフロー例

n8n では以下のような自動化が可能です：

1. **Web フック → Slack 通知**
2. **スケジュール実行 → データベース更新**
3. **API 連携 → ファイル処理**
4. **メール受信 → 自動返信**

詳細は n8n 公式ドキュメント: https://docs.n8n.io/

## リソース使用量

- **最小推奨**: 2GB RAM, 2 CPU
- **本番推奨**: 4GB RAM, 4 CPU
- **ディスク**: 最低 10GB（ワークフローデータによる）

## アップデート

```bash
docker-compose -f n8n.yml pull
docker-compose -f n8n.yml up -d
```

データは永続化されているため、アップデート後もワークフローは保持されます。
