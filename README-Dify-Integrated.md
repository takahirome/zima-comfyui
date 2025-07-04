# Dify 統合 Docker Compose - ZimaOS 対応

このファイルは、ZimaOS 用に最適化された Dify の統合 Docker Compose ファイルです。すべての設定とセットアップが 1 つのファイルに統合されており、外部ファイルを必要としません。

## 特徴

- **オールインワン**: すべての設定が 1 つのファイルに統合
- **自動初期化**: 必要なディレクトリとファイルを自動作成
- **ZimaOS 最適化**: `/DATA/AppData/` パスを使用
- **Sandbox 問題解決**: 依存関係ファイルを自動配置
- **アイコン対応**: ZimaOS の UI で適切なアイコンを表示

## アイコンについて

Dify の公式アイコンは以下の URL を使用しています：

```
https://raw.githubusercontent.com/langgenius/dify/main/web/public/logo/logo-site.png
```

このアイコンは[Dify のブランドガイドライン](https://docs.dify.ai/ja-jp/resources/about-dify/dify-brand-guidelines)に準拠しており、ZimaOS や Homepage、その他のダッシュボードで正しく表示されます。

## 使用方法

### 1. ファイルのダウンロード

```bash
# GitHubからダウンロード
wget https://raw.githubusercontent.com/your-repo/docker-compose-dify-all-in-one.yml

# または、このリポジトリをクローン
git clone https://github.com/your-repo/zima-openwebui.git
cd zima-openwebui
```

### 2. Dify の起動

```bash
# 単一コマンドで起動
docker-compose -f docker-compose-dify-all-in-one.yml up -d
```

### 3. 状態確認

```bash
# すべてのサービスの状態を確認
docker-compose -f docker-compose-dify-all-in-one.yml ps

# ログの確認
docker-compose -f docker-compose-dify-all-in-one.yml logs dify-sandbox
```

### 4. アクセス

- **Dify Web UI**: `http://your-zimaos-ip:3701`
- **Plugin Daemon**: `http://your-zimaos-ip:5003`

## 含まれるサービス

| サービス           | 説明                       | ポート |
| ------------------ | -------------------------- | ------ |
| dify-init          | 初期化コンテナ（自動実行） | -      |
| dify-api           | Dify API サーバー          | 5001   |
| dify-worker        | バックグラウンドワーカー   | -      |
| dify-web           | フロントエンド Web アプリ  | 3000   |
| dify-db            | PostgreSQL データベース    | 5432   |
| dify-redis         | Redis キャッシュ           | 6379   |
| dify-weaviate      | ベクトルデータベース       | 8080   |
| dify-sandbox       | コード実行環境             | 8194   |
| dify-plugin-daemon | プラグインデーモン         | 5003   |
| dify-nginx         | リバースプロキシ           | 3701   |

## 自動作成されるファイル

初期化コンテナが以下のファイルを自動作成します：

### `/DATA/AppData/Dify/sandbox/python-requirements.txt`

```
requests>=2.25.0
numpy>=1.21.0
pandas>=1.3.0
matplotlib>=3.4.0
seaborn>=0.11.0
scikit-learn>=1.0.0
plotly>=5.0.0
beautifulsoup4>=4.10.0
lxml>=4.6.0
openpyxl>=3.0.0
pillow>=8.0.0
python-dateutil>=2.8.0
pytz>=2021.1
scipy>=1.7.0
```

### `/DATA/AppData/Dify/sandbox/package.json`

```json
{
  "name": "dify-sandbox-nodejs",
  "version": "1.0.0",
  "description": "Node.js dependencies for Dify sandbox",
  "dependencies": {
    "axios": "^1.3.0",
    "lodash": "^4.17.21",
    "moment": "^2.29.0",
    "cheerio": "^1.0.0-rc.12",
    "csv-parser": "^3.0.0",
    "node-fetch": "^3.3.0"
  }
}
```

## トラブルシューティング

### Sandbox が unhealthy の場合

```bash
# ログを確認
docker logs dify-sandbox

# 依存関係ファイルの確認
ls -la /DATA/AppData/Dify/sandbox/

# サービスの再起動
docker-compose -f docker-compose-dify-all-in-one.yml restart dify-sandbox
```

### 初期化コンテナが失敗する場合

```bash
# 初期化コンテナのログを確認
docker logs dify-init

# 手動でディレクトリを作成
sudo mkdir -p /DATA/AppData/Dify/{storage,db,redis,weaviate,sandbox,plugin-daemon}
sudo chmod -R 755 /DATA/AppData/Dify/
```

### 完全なリセット

```bash
# すべてのコンテナとボリュームを削除
docker-compose -f docker-compose-dify-all-in-one.yml down -v

# データディレクトリの削除（注意：すべてのデータが失われます）
sudo rm -rf /DATA/AppData/Dify/

# 再起動
docker-compose -f docker-compose-dify-all-in-one.yml up -d
```

## ZimaOS での表示

この Docker Compose ファイルには、ZimaOS の UI で適切に表示されるためのラベルが含まれています：

- **アイコン**: Dify の公式ロゴ
- **グループ**: AI Services
- **説明**: Open-source LLM App Development Platform
- **リンク**: http://localhost:3701

## サポート

問題が発生した場合は、以下の情報を含めてレポートしてください：

1. `docker-compose -f docker-compose-dify-all-in-one.yml logs` の出力
2. `docker ps -a` の出力
3. `/DATA/AppData/Dify/` ディレクトリの内容
4. ZimaOS のバージョン情報

## ライセンス

この Docker Compose ファイルは、Dify の公式ライセンスに従います。詳細は[Dify の公式リポジトリ](https://github.com/langgenius/dify)を参照してください。
