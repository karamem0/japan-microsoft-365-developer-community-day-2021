[目次に戻る](README.md#目次)

# React プロジェクトを作成する

Teams アプリ (個人用タブ) は Microsoft Teams から iframe でホストされる Web サイトです。そのため最初に Web サイトを作成する必要があります。

## React プロジェクトをクローンする

今回のハンズオンでは事前にセットアップされたプロジェクトを使用します。

GitHub からコードをクローンします。コマンド プロンプトで以下のコマンドを実行します。

```cmd
git clone https://github.com/karamem0/japan-microsoft365-developer-community-day-2021.git
```

`client` フォルダーにプロジェクトが存在することを確認します。

このプロジェクトは以下の手順で作成しています。**以下は読み飛ばして構いません。**

1. `create-react-app` を使ってプロジェクトを作成します。

    ```cmd
    npx create-react-app my-teams-app --template typescript
    ```

1. React のバージョンを 16 に変更します。(Fluent UI が 16 までにしか対応していないため)

    ```cmd
    npm install react@^16 react-dom@^16 @types/react@^16 @types/react-dom@^16
    ```

1. Microsoft Teams JavaScript Client SDK を追加します。

    ```cmd
    npm install @microsoft/teams-js
    ```

1. Fluent UI を追加します。

    ```cmd
    npm install @fluentui/react-northstar @fluentui/react-icons-mdl2 @fluentui/react-icons-mdl2-branded
    ```

1. Microsoft Graph Toolkit を追加します。

    ```cmd
    npm install @microsoft/mgt-react
    ```

1. ESLint を追加します。

    ```cmd
    npm install eslint eslint-plugin-react eslint-plugin-react-hooks @typescript-eslint/eslint-plugin@^4
    ```

1. Stylelint を追加します。

    ```cmd
    npm install stylelint stylelint-config-recommended
    ```

1. Jest を追加します。

    ```cmd
    npm install ts-jest@^26
    ```

1. Testing Library を追加します。

    ```cmd
    npm install @testing-library/react-hooks
    ```

1. `.eslintrc.json` を追加します。

    ```json
    {
        "env": {
            "browser": true,
            "es2021": true,
            "jest": true
    },
        "extends": [
            "eslint:recommended",
            "plugin:react/recommended",
            "plugin:react-hooks/recommended",
            "plugin:@typescript-eslint/recommended"
        ]
    }
    ```

1. `.stylelintrc.json` を追加します。

    ```json
    {
        "extends": [
            "stylelint-config-recommended"
        ]
    }
    ```

1. `jest.config.json` を追加します。

    ```json
    {
        "globals": {
            "ts-jest": {
            "isolatedModules": "disabled"
            }
        },
        "testMatch": [
            "**/*.spec.ts",
            "**/*.spec.tsx"
        ],
        "transform": {
            "^.+\\.(ts|tsx)$": "ts-jest"
        }
    }
    ```

## パッケージをインストールする

`client` フォルダーで以下のコマンドを実行します。

```cmd
npm install
```

この操作は時間がかかるためしばらく待ちます。実行後エラーが出ていないことを確認します。

## 証明書をインストールする

デバッグは `localhost` で行いますが、Microsoft Teams は HTTPS しか認識しないため、自己証明書を使って `localhost` にアクセスできるようにします。

`client` フォルダーで以下の PowerShell を実行します。

```ps1
./trust-dev-cert.ps1
```

この証明書は以下の手順で作成しています。**以下は読み飛ばして構いません。**

1. 自己証明書を作成します。

    ```ps1
    New-SelfSignedCertificate -DnsName "localhost" -NotBefore "1900/1/1" -NotAfter "2099/12/31" -CertStoreLocation "cert:\CurrentUser\My"
    ```

1. **ユーザー証明書の管理**から作成した自己証明書を PFX 形式でエクスポートします。

1. [OpenSSL](http://slproweb.com/products/Win32OpenSSL.html) をインストールします。

1. PFX ファイルから CRT ファイルを作成します。

    ```cmd
    openssl pkcs12 -in localhost.pfx -clcerts -nokeys -out localhost.crt
    ```

1. PFX ファイルから KEY ファイルを作成します。

    ```cmd
    openssl pkcs12 -in localhost.pfx -nocerts -nodes -out localhost.key
    ```

## 動作を確認する

1. `client` フォルダーで以下のコマンドを実行します。

    ```cmd
    npm run start
    ```

    ビルドが成功すると以下のメッセージが表示されます。

    ```cmd
    Compiled successfully!

    You can now view my-teams-app in the browser.

    Local:            https://localhost:3000
    On Your Network:  https://172.16.80.180:3000

    Note that the development build is not optimized.
    To create a production build, use npm run build.
    ```

1. ブラウザーで `https://localhost:3000` にアクセスします。

1. ページが正しく表示されることを確認します。

---

お疲れさまでした！次のセクションでは作成したアプリを Microsoft Teams に接続する方法を学習します。

[Teams アプリを作成する](02_create-teams-app.md)
