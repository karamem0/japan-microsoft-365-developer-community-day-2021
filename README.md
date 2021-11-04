# Japan Microsoft 365 Developer Community Day 2021

[Japan Microsoft 365 Developer Community Day 2021](https://jpm365dev.connpass.com/event/227478) の Microsoft Teams のハンズオン資料です。

## 事前準備

開発用の Microsoft 365 環境を用意する必要があります。Microsoft 365 開発者プログラムにご登録ください。

[Microsoft 365 開発者プログラム](https://developer.microsoft.com/ja-jp/microsoft-365/dev-program)

ハンズオンを受講するにあたり以下のソフトウェアをインストールする必要があります。
- [Node.js](https://nodejs.org) (v16.13.0)
- [Visual Studio Code](https://code.visualstudio.com)
    - C# 拡張
- [Git for Windows](https://gitforwindows.org)
- [.NET Core 3.1 SDK](https://dotnet.microsoft.com/download/dotnet/3.1)
- [Google Chrome](https://www.google.co.jp/intl/ja/chrome)

コンピューターは Windows 10 または Windows 11 をお使いください。

## 目次

1. [React プロジェクトを作成する](01_create-react-app.md)
    1. React プロジェクトをクローンする
    1. パッケージをインストールする
    1. 証明書をインストールする
    1. 動作を確認する
1. [Teams アプリを作成する](02_create-teams-app.md)
    1. アプリを作成する
    1. アプリの基本情報を設定する
    1. アプリの個人用タブを構成する
    1. アプリをインストールする
1. [シングル サインオンを実装する](03_imprement-single-sign-on.md)
    1. Azure AD アプリケーションを登録する
    1. Teams アプリ マニフェストを修正する
    1. React プロジェクトのコードを修正する
    1. 動作を確認する
1. [Microsoft Graph API を実行する](04_call-microsoft-graph-api.md)
    1. C# プロジェクトを作成する
    1. C# プロジェクトのコードを修正する
    1. C# プロジェクトを実行する
    1. React プロジェクトのコードを修正する
    1. 動作を確認する
1. [Microsoft Teams のテーマを適用する](05_apply-theme.md)
    1. React プロジェクトのコードを修正する
    1. 動作を確認する
