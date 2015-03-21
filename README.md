MailMug
===

* Author:: Yuichi Takeuchi <info@takeyu-web.com>
* Website:: http://takeyu-web.com/
* Copyright:: Copyright 2015 Yuichi Takeuchi
* License:: MIT License

Movable Type でメールマガジンを配信・管理できるようになります。

##動作しそうな環境

###要件

* Movable Type バージョン
  * 5.1 / 5.2 / 6.X
　* クラウド版
* CRONが設定可能
* MySQL（その他のDBMSは未検証）

###レンタルサーバ（動作報告のあったもの）

* エックスサーバー

##インストール

1. `MT_DIR/plugins` にZIPファイル内 `MailMug` をアップロード
2. Movable Typeにアクセスし、アップグレード指示に従う
4. CRON等で`run-periodic-tasks`を設定（http://www.movabletype.jp/documentation/schedule_task_framework.html）
5. （できれば）MySQLの`mt_mail_mug_subscripter`テーブルをInnoDBに変更する
  ※メール配信キューのトランザクションを利用できるようにするため

##使い方

1. テーマ「MailMug」でブログを作成
2. ブログの設定で MailMug で有効にする
3. 購読者追加（一括インポート可能）
4. 記事を作成して「配信許可」公開

##できること

### 機能

- ブログ記事をメールとして管理
  - 指定日時配信OK
  - バックナンバーをMTのブログ記事テンプレートで簡単に作成可能
- HTMLメール / テキストメール 両対応
- HTMLメールで本文中に画像使用可能
  - 自動的にメールの添付ファイルとして埋め込みます
- メルマガ購読者を改行区切りファイル（CSV）でインポート可能
- メルマガ購読者をMTのロール＆権限モデルで管理可能

### 設定

- HTMLメール / テキストメール 両対応。
- メール文字コード 
  - UTF-8 or JIS(ISO-2022-JP)
- メール返信先（Reply-To）
- エラー返送先（Return-Path）
- メールテンプレートカスタマイズ可能
  - ブログのシステムテンプレートに追加されます
- メールマガジン送信専用のSMTP設定が可能

### 性能

- レンタルサーバ上のMovable Typeから数千通規模のメルマガ配信実績あり
- メール配信のレジューム
  - エラーやプロセス終了時、自動的に続きから配信
- 購読者インポートの際、記事の再構築と同様の仕組みで一定数ずつ読み込むため、タイムアウトを抑制。大量のアドレスも安定して登録可能。

##TODO（やりたいこと・まだできてないこと）

### 機能

- 購読者が自分でメルマガ登録＆解除するためのフォームCGI
- メール配信タスク登録部分の非同期化（大量のとき記事登録に時間がかかるので）
- メール送信のスロットリング（メールサーバへの負荷対策）

### 管理

- 返送先メールボックスをチェックして、一定数返送されたユーザを無効化
- メールプレビュー
- 指定したユーザに対してテスト送信
- メール配信タスクの管理（配信状況確認、配信中止など）
- 配信登録エラーがわかるようにする

##有償サポート

設置代行、カスタマイズなどは有償にて承ります。まずはお見積もり。
ただし、有不具合等につきまして対応を保障するものではありませんのでご注意下さい。


##ご注意

* 無保証です。このプラグインを使用したことでいかなる損害が発生しても一切責任を負いません。
* ノンサポートのオープンソースソフトウェアです。サポートが必要な方は、有償の製品の導入をご検討下さい。


