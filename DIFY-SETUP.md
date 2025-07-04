# Dify for ZimaOS セットアップガイド

このガイドでは、ZimaOS 上で Dify を正常に動作させるための手順を説明します。

## 問題の説明

Dify sandbox コンテナが `unhealthy` 状態になる問題は、以下のエラーが原因です：

```
failed to setup runner dependencies: open dependencies/python-requirements.txt: no such file or directory
```

## 解決方法

### 1. セットアップスクリプトの実行

まず、必要なディレクトリとファイルを作成します：

```bash
chmod +x setup-dify-sandbox.sh
sudo ./setup-dify-sandbox.sh
```

### 2. Docker Compose での起動

ZimaOS 用の Docker Compose ファイルを使用して Dify を起動します：

```bash
docker-compose -f docker-compose-dify.yml up -d
```

### 3. 状態確認

すべてのコンテナが正常に起動していることを確認します：

```bash
docker-compose -f docker-compose-dify.yml ps
```

## 主な変更点

### 1. ネットワーク設定の改善

- `network_mode: bridge` から専用ネットワーク `dify-network` に変更
- コンテナ間の通信を改善

### 2. Sandbox 依存関係の解決

- `/DATA/AppData/Dify/sandbox/python-requirements.txt` を作成
- `/DATA/AppData/Dify/sandbox/package.json` を作成
- 必要な Python および Node.js パッケージを事前定義

### 3. ヘルスチェックの調整

- sandbox のヘルスチェック間隔を調整（30 秒間隔）
- より安定したヘルスチェック設定

### 4. Nginx 設定の分離

- 設定ファイルを外部ファイルとして分離
- メンテナンスが容易に

## ディレクトリ構造

```
/DATA/AppData/Dify/
├── storage/          # APIストレージ
├── db/              # PostgreSQLデータ
├── redis/           # Redisデータ
├── weaviate/        # Weaviateベクトルデータ
├── sandbox/         # Sandboxの依存関係
│   ├── python-requirements.txt
│   └── package.json
└── plugin-daemon/   # プラグインデーモンストレージ
```

## アクセス方法

Dify が正常に起動したら、以下の URL でアクセスできます：

- **Dify Web UI**: `http://your-zimaos-ip:3701`
- **Plugin Daemon**: `http://your-zimaos-ip:5003`

## トラブルシューティング

### Sandbox が依然として unhealthy の場合

1. ログを確認：

   ```bash
   docker logs dify-sandbox
   ```

2. 依存関係ファイルの存在確認：

   ```bash
   ls -la /DATA/AppData/Dify/sandbox/
   ```

3. コンテナの再起動：
   ```bash
   docker-compose -f docker-compose-dify.yml restart dify-sandbox
   ```

### データベース接続問題

1. PostgreSQL の状態確認：

   ```bash
   docker logs dify-db
   ```

2. データベースの初期化：
   ```bash
   docker-compose -f docker-compose-dify.yml down
   sudo rm -rf /DATA/AppData/Dify/db/*
   docker-compose -f docker-compose-dify.yml up -d
   ```

## 注意事項

- ZimaOS では `/DATA/AppData/` パスを使用することが推奨されます
- 初回起動時は、すべての依存関係のダウンロードに時間がかかる場合があります
- システムリソースが不足している場合は、`deploy.resources` セクションでメモリ制限を調整してください

## サポート

問題が発生した場合は、以下の情報を含めてレポートしてください：

1. `docker-compose -f docker-compose-dify.yml logs` の出力
2. `docker ps -a` の出力
3. `/DATA/AppData/Dify/` ディレクトリの内容
4. ZimaOS のバージョン情報
