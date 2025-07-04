# ZimaOS AI & Automation Platform

このプロジェクトは、ZimaOS で AI 関連サービスと自動化ツールを統合して動作させるための Docker Compose ファイル集です。複数の AI サービスを組み合わせて、包括的な AI 開発・運用環境を構築できます。

## 🚀 含まれるサービス

### 🤖 AI プラットフォーム

- **Dify** - オープンソースの LLM アプリケーション開発プラットフォーム
- **Ollama** - ローカル LLM ランナー（Llama 2、Mistral 等をサポート）
- **OpenWebUI** - LLM 用のユーザーフレンドリーな WebUI

### 🎨 画像生成 AI

- **Stable Diffusion Forge** - 高性能な Stable Diffusion WebUI
- **ComfyUI** - ノードベースの Stable Diffusion GUI

### 🔧 自動化・ワークフロー

- **n8n** - 自動化・ワークフロー管理ツール

## 📋 システム要件

- **Docker & Docker Compose**
- **最低 RAM**: 16GB（推奨 32GB 以上）
- **GPU**: NVIDIA GPU（画像生成 AI 用、オプション）
- **ディスク容量**: 50GB 以上の空き容量
- **OS**: ZimaOS、Linux、macOS、Windows

## 🔧 セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd zima-openwebui
```

### 2. データディレクトリの作成

```bash
# Dify用
mkdir -p dify-data/{storage,db,redis,weaviate,sandbox,plugin-daemon}

# その他のサービス用
sudo mkdir -p /DATA/AppData/{Ollama,OpenWebUI,n8n/{postgres,redis,data,files,nginx,ssl}}
sudo mkdir -p /DATA/Storage/Stable-Diffusion-WebUI-Forge/
sudo mkdir -p /DATA/AppData/Storage  # ComfyUI用

# 権限設定
sudo chown -R $USER:$USER /DATA/AppData/
```

### 3. サービスの起動

各サービスは個別に起動できます：

```bash
# Dify（メインのDocker Compose）
docker-compose up -d

# Ollama
docker-compose -f Ollama.yml up -d

# OpenWebUI
docker-compose -f OpenWebUI.yml up -d

# Stable Diffusion Forge
docker-compose -f StableDiffusionForge.yml up -d

# ComfyUI
docker-compose -f ComfyUI.yal up -d

# n8n
docker-compose -f n8n.yml up -d
```

### 4. 全サービス一括起動

```bash
# 全サービスを一度に起動
docker-compose up -d && \
docker-compose -f Ollama.yml up -d && \
docker-compose -f OpenWebUI.yml up -d && \
docker-compose -f StableDiffusionForge.yml up -d && \
docker-compose -f ComfyUI.yal up -d && \
docker-compose -f n8n.yml up -d
```

## 🌐 アクセス情報

| サービス                   | URL                    | ポート | 説明                           |
| -------------------------- | ---------------------- | ------ | ------------------------------ |
| **Dify**                   | http://localhost:3701  | 3701   | LLM アプリ開発プラットフォーム |
| **Ollama**                 | http://localhost:11434 | 11434  | LLM API エンドポイント         |
| **OpenWebUI**              | http://localhost:3000  | 3000   | LLM 用 WebUI                   |
| **Stable Diffusion Forge** | http://localhost:7860  | 7860   | 画像生成 WebUI                 |
| **ComfyUI**                | http://localhost:8188  | 8188   | ノードベース画像生成 UI        |
| **n8n**                    | http://localhost:8080  | 8080   | 自動化・ワークフロー管理       |

## 🔗 サービス間連携

### LLM エコシステム

1. **Ollama** でローカル LLM モデルをホスト
2. **OpenWebUI** で Ollama に接続してチャット
3. **Dify** で Ollama の API を利用してアプリケーション開発

### 画像生成パイプライン

1. **Stable Diffusion Forge** で基本的な画像生成
2. **ComfyUI** で高度なワークフロー構築
3. **n8n** で画像生成プロセスの自動化

### 自動化統合

- **n8n** を使用して各サービス間のワークフロー自動化
- Webhook、API 呼び出し、スケジュール実行が可能

## 📊 サービス詳細

### Dify

- **機能**: LLM アプリケーション開発プラットフォーム
- **主要コンポーネント**: API、Worker、WebUI、PostgreSQL、Redis、Weaviate
- **用途**: RAG アプリケーション、チャットボット、AI エージェント開発

### Ollama

- **機能**: ローカル LLM ランナー
- **対応モデル**: Llama 2、Mistral、CodeLlama 等
- **用途**: プライベート LLM ホスティング、API 提供

### OpenWebUI

- **機能**: LLM 用 WebUI（旧 Ollama WebUI）
- **特徴**: ChatGPT 風インターフェース、Ollama 連携
- **用途**: 直感的な LLM チャット体験

### Stable Diffusion Forge

- **機能**: 高性能 Stable Diffusion WebUI
- **特徴**: 拡張機能サポート、高速処理
- **用途**: 高品質画像生成、アート作成

### ComfyUI

- **機能**: ノードベース Stable Diffusion GUI
- **特徴**: 視覚的ワークフロー構築、高度なカスタマイズ
- **用途**: 複雑な画像生成パイプライン構築

### n8n

- **機能**: 自動化・ワークフロー管理
- **特徴**: 200+のサービス連携、視覚的ワークフロー
- **用途**: プロセス自動化、サービス間連携

## 🛠️ 設定とカスタマイズ

### 環境変数の変更

各 YAML ファイルで環境変数をカスタマイズできます：

```yaml
# 例：Difyの設定変更
environment:
  - SECRET_KEY=your-secret-key
  - DB_PASSWORD=your-db-password
```

### リソース制限の調整

メモリや CPU 使用量を調整：

```yaml
deploy:
  resources:
    limits:
      memory: 8192M # 8GB制限
```

### ポート変更

競合を避けるためのポート変更：

```yaml
ports:
  - "新しいポート:コンテナポート"
```

## 📁 データ永続化

### Dify

- `./dify-data/storage/` - ファイルストレージ
- `./dify-data/db/` - PostgreSQL データ
- `./dify-data/redis/` - Redis データ
- `./dify-data/weaviate/` - ベクターデータ

### その他のサービス

- `/DATA/AppData/Ollama/` - Ollama モデル
- `/DATA/AppData/OpenWebUI/` - OpenWebUI データ
- `/DATA/Storage/Stable-Diffusion-WebUI-Forge/` - SD モデル・出力
- `/DATA/AppData/Storage/` - ComfyUI データ
- `/DATA/AppData/n8n/` - n8n ワークフロー・データ

## 🔒 セキュリティ設定

### 本番環境での推奨変更

1. **認証情報の変更**

   - データベースパスワード
   - API キー
   - 暗号化キー

2. **アクセス制限**

   - ファイアウォール設定
   - リバースプロキシ設定
   - SSL/TLS 証明書

3. **n8n の基本認証**
   ```yaml
   - N8N_BASIC_AUTH_USER=your-username
   - N8N_BASIC_AUTH_PASSWORD=your-password
   ```

## 🚨 トラブルシューティング

### 共通問題

#### メモリ不足

```bash
# メモリ使用量確認
docker stats

# 不要なコンテナ停止
docker-compose down [サービス名]
```

#### ポート競合

```bash
# ポート使用状況確認
sudo netstat -tulpn | grep :[ポート番号]
```

#### GPU 認識問題

```bash
# NVIDIA Docker確認
docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```

### サービス固有の問題

#### Ollama：モデルダウンロード

```bash
docker exec -it icewhale-ollama ollama pull llama2
```

#### Stable Diffusion：モデル配置

```bash
# モデルを適切なディレクトリに配置
cp your-model.safetensors /DATA/Storage/Stable-Diffusion-WebUI-Forge/models/Stable-diffusion/
```

## 📚 使用例・ワークフロー

### 1. AI アプリケーション開発

1. Ollama でローカルモデルを起動
2. Dify で Ollama API を設定
3. RAG アプリケーションを構築

### 2. 自動画像生成パイプライン

1. n8n でスケジュール設定
2. ComfyUI の API を呼び出し
3. 生成画像を自動保存・配信

### 3. 統合 AI ワークフロー

1. n8n で Webhook 受信
2. Dify API でテキスト処理
3. Stable Diffusion で画像生成
4. 結果を自動通知

## 🔄 メンテナンス

### バックアップ

```bash
# データディレクトリのバックアップ
tar -czf backup-$(date +%Y%m%d).tar.gz dify-data/ /DATA/AppData/ /DATA/Storage/
```

### アップデート

```bash
# イメージ更新
docker-compose pull
docker-compose -f Ollama.yml pull
docker-compose -f OpenWebUI.yml pull
# ... 他のサービスも同様

# 再起動
docker-compose up -d
```

### クリーンアップ

```bash
# 全サービス停止
docker-compose down
docker-compose -f Ollama.yml down
docker-compose -f OpenWebUI.yml down
docker-compose -f StableDiffusionForge.yml down
docker-compose -f ComfyUI.yal down
docker-compose -f n8n.yml down

# データ削除（注意：全データが削除されます）
rm -rf dify-data/
sudo rm -rf /DATA/AppData/
sudo rm -rf /DATA/Storage/
```

## 📖 参考資料

- [Dify 公式ドキュメント](https://docs.dify.ai)
- [Ollama 公式サイト](https://ollama.ai)
- [OpenWebUI GitHub](https://github.com/open-webui/open-webui)
- [Stable Diffusion Forge](https://github.com/lllyasviel/stable-diffusion-webui-forge)
- [ComfyUI GitHub](https://github.com/comfyanonymous/ComfyUI)
- [n8n 公式ドキュメント](https://docs.n8n.io)

## 📄 ライセンス

各サービスは個別のライセンスに従います。詳細は各プロジェクトのライセンスファイルを確認してください。

## 🤝 コントリビューション

改善提案やバグレポートは、Issues または Pull Requests でお願いします。
