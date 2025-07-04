# Dify for ZimaOS

このプロジェクトは、ZimaOSでDifyを動作させるためのDocker Composeファイルです。

## 概要

Difyは、オープンソースのLLMアプリケーション開発プラットフォームです。AIワークフロー、RAGパイプライン、エージェント機能、モデル管理、可観測性機能などを統合し、プロトタイプから本番環境まで迅速に移行できます。

## 必要なシステム要件

- Docker
- Docker Compose
- 最低8GB RAM（推奨16GB以上）
- 10GB以上の空きディスク容量

## セットアップ

1. このリポジトリをクローンまたはダウンロードします：
   ```bash
   git clone <repository-url>
   cd zima-openwebui
   ```

2. データディレクトリを作成します：
   ```bash
   mkdir -p dify-data/{storage,db,redis,weaviate,sandbox,plugin-daemon}
   ```

3. Docker Composeでサービスを起動します：
   ```bash
   docker-compose up -d
   ```

4. 初回起動時は、すべてのサービスが立ち上がるまで数分待ちます。

## アクセス

- **Dify Web UI**: http://localhost:3701
- **Plugin Daemon**: http://localhost:5003

## サービス構成

- **dify-api**: Dify APIサーバー
- **dify-worker**: バックグラウンドワーカー
- **dify-web**: WebUIフロントエンド
- **dify-db**: PostgreSQLデータベース
- **dify-redis**: Redisキャッシュ
- **dify-weaviate**: Weaviateベクターデータベース
- **dify-sandbox**: コード実行サンドボックス
- **dify-plugin-daemon**: プラグインデーモン
- **dify-nginx**: リバースプロキシ

## データの永続化

すべてのデータは `./dify-data/` ディレクトリに保存されます：
- `storage/`: ファイルストレージ
- `db/`: PostgreSQLデータ
- `redis/`: Redisデータ
- `weaviate/`: Weaviateベクターデータ
- `sandbox/`: サンドボックス依存関係
- `plugin-daemon/`: プラグインデータ

## 停止とクリーンアップ

サービスを停止するには：
```bash
docker-compose down
```

データを含めて完全にクリーンアップするには：
```bash
docker-compose down -v
rm -rf dify-data/
```

## トラブルシューティング

### メモリ不足エラー
システムRAMが不足している場合は、`docker-compose.yml`の`deploy.resources.limits.memory`値を調整してください。

### ポート競合
ポート3701または5003が使用中の場合は、`docker-compose.yml`のポート設定を変更してください。

### 初回起動が遅い
初回起動時は、すべてのDockerイメージのダウンロードと初期化に時間がかかります。ログを確認してください：
```bash
docker-compose logs -f
```

## セキュリティ注意事項

本番環境で使用する場合は、以下の設定を変更してください：
- `SECRET_KEY`
- データベースパスワード
- Redis パスワード
- Weaviate API キー
- その他のAPI キー

## サポート

問題が発生した場合は、以下を確認してください：
1. Dockerとdocker-composeが正しくインストールされているか
2. 必要なポートが利用可能か
3. 十分なシステムリソースがあるか

詳細については、[Dify公式ドキュメント](https://docs.dify.ai)を参照してください。
