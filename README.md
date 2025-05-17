# zima-stable-dock

このリポジトリは、zimacube にインストールするための Docker 定義ファイルを提供します。

## 概要

- zimacube 上で Stable Diffusion などの AI モデルを動作させるための Docker 構成ファイルです。
- `ComfyUI.yaml`および`Stable Diffusion.yaml`が含まれています。

## ファイル説明

- `ComfyUI.yaml`: ComfyUI の Docker 定義ファイル

  - ポート番号: 8188
  - イメージ: yanwk/comfyui-boot:latest
  - モデル・出力・カスタムノードの保存先: `/DATA/AppData/ComfyUI/`
  - 説明: グラフ/ノードインターフェースを備えた強力でモジュール式の Stable Diffusion 用 GUI およびバックエンド

- `Stable Diffusion.yaml`: Stable Diffusion の Docker 定義ファイル
  - ポート番号: 7860
  - イメージ: johnguan/stable-diffusion-webui:latest
  - モデル・出力・設定の保存先: `/DATA/AppData/Stable-Diffusion-WebUI/`
  - 説明: テキストの説明に基づいて詳細な画像を生成するための AI モデル

## システム要件

- GPU サポート: NVIDIA GPU 推奨（GPU 環境がない場合は CPU フォールバックあり）
- メモリ要件: 最低 512MB、推奨 16GB
- ストレージ: モデルファイル用に十分な空き容量が必要
- zimacube がインストールされた環境

## 使い方

1. 本リポジトリを zimacube 上にクローンまたはファイルをコピーします。
2. zimacube の管理画面や CLI から、必要な yaml ファイルを指定して Docker コンテナーを起動します。
3. 詳細設定はこちらを参照
   1. https://github.com/YanWenKun/ComfyUI-Docker/blob/main/cu121/README.adoc

例：

```sh
# 例: CLIから起動する場合
docker compose -f ComfyUI.yaml up -d
docker compose -f Stable Diffusion.yaml up -d
```

※ 実際の起動方法は zimacube の仕様にしたがってください。

## アクセス方法

- ComfyUI: `http://[zimacubeのIPアドレス]:8188`
- Stable Diffusion: `http://[zimacubeのIPアドレス]:7860`

## トラブルシューティング

- コンテナーが起動しない場合:
  - GPU ドライバが正しくインストールされているか確認
  - メモリ不足の可能性がある場合はリソース設定を見直し
- モデルが読み込めない場合:
  - ボリューム設定が正しいか確認
  - 適切なモデルファイルがダウンロードされているか確認

## ライセンス

MIT ライセンス (注：実際のライセンスに合わせて修正してください)

## 貢献について

バグ報告や機能改善の提案は、Issue またはプルリクエストでお願いします。
