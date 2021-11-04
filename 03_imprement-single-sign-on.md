[目次に戻る](README.md#目次)

# シングル サインオンを実装する

組織内で使うためにアプリをセキュリティ保護することは重要です。Microsoft Teams の資格情報を使ってサインオンすることでシームレスなユーザー体験を提供します。

## Azure AD アプリケーションを登録する

Microsoft Teams にサインインしたアカウントでアプリに接続できるように構成するには Azure AD にアプリケーションを登録する必要があります。

### Azure AD アプリケーションを登録する

1. [**Azure ポータル**](https://portal.azure.com) にログインします。

1. メニューの **Azure Active Directory** をクリックします。

1. **アプリの登録** をクリックします。

1. **新規登録** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |名前|`MyTeamsApp`|
    |サポートされているアカウントの種類|`この組織ディレクトリのみに含まれるアカウント`|
    |リダイレクト URI|`https://localhost:3000`|

1. **登録** をクリックします。

1. **アプリケーション (クライアント) ID** および **ディレクトリ (テナント) ID** をメモ帳などにコピーします。

### Azure AD アプリケーションのプラットフォーム構成を設定する

1. **認証** をクリックします。

1. **暗黙的な許可およびハイブリッド フロー** の以下のチェック ボックスを選択します。

    - アクセス トークン
    - ID トークン

1. **保存** をクリックします。

### Azure AD アプリケーションのクライアント シークレットを取得する

1. **証明書とシークレット** をクリックします。

1. **新しいクライアント シークレット** をクリックします。

1. 既定値のままで **追加** をクリックします。

1. 表示された **値** をメモ帳などにコピーします。

### Azure AD アプリケーションの API スコープを設定する

1. **API の公開** をクリックします。

1. **スコープの追加** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |アプリケーション ID の URI|`api://localhost:3000/{client_id}`|

1. **保存してから続ける** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |スコープ名|`access_as_user`|
    |同意できるのはだれですか?|`管理者とユーザー`|
    |管理者の同意の表示名|`アプリのアクセス`|
    |管理者の同意の説明|`アプリはユーザーの代わりにデータにアクセスします`|
    |ユーザーの同意の表示名|`アプリのアクセス`|
    |ユーザーの同意の説明|`アプリはユーザーの代わりにデータにアクセスします`|
    |状態|`有効`|

1. **スコープの追加** をクリックします。

1. **クライアント アプリケーションの追加** をクリックします。

1. 以下のクライアント ID を入力します。

    |クライアント ID|
    |-|
    |`1fec8e78-bce4-4aaf-ab1b-5451cc387264`|

1. 以下の承認済みのスコープを選択します。

    |承認済みスコープ|
    |-|
    |`api://localhost:3000/{client_id}/access_as_user`|

1. **アプリケーションの追加** をクリックします。

1. 同様に以下のクライアント ID も追加します。

    |クライアント ID|
    |-|
    |`5e3ce6c0-2b1f-4285-8d4b-75ee78787346`|

## Teams アプリ マニフェストを修正する

1. [**Teams 開発者ポータル**](https://dev.teams.microsoft.com) にログインします。

1. アプリ バーの **Apps** をクリックします。

1. **my-teams-app** をクリックします。

1. **Basic Information** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |Application (client) ID|`{client_id}`|

1. **Save** をクリックします。

1. **Single sign-on** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |Application ID URI|`api://localhost:3000/{client_id}`|

1. **Save** をクリックします。

## React プロジェクトのコードを修正する

### Visual Studio Code でプロジェクトを開く

1. Visual Studio Code を起動します。

1. メニュー バーの **ファイル** - **フォルダーを開く** から `client` フォルダーを開きます。

### launch.json を修正する

1. メニュー バーの **実行** - **構成を開く** をクリックします。(または `.vscode/launch.json` を開きます。)

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |url|`https://teams.microsoft.com/_#/l/app/{teams_app_id}?installAppPackage=true`|

1. `Ctrl+S` でファイルを保存します。

### App.tsx を修正する

1. `src/App.tsx` を開きます。

1. 以下のコードを入力します。

    ```diff
    import React from 'react';
    + import * as microsoftTeams from '@microsoft/teams-js';
    - import { Header } from '@fluentui/react-northstar';
    + import { Header, TextArea } from '@fluentui/react-northstar';
    import './App.css';
    ```

1. 以下のコードを入力します。

    ```diff
    + const [clientToken, setClientToken] = React.useState<string>();
    + React.useEffect(() => {
    +   microsoftTeams.initialize();
    +   microsoftTeams.authentication.getAuthToken({
    +     successCallback: (token) => setClientToken(token),
    +     failureCallback: (error) => console.error(error)
    +   });
    + }, []);
    ```

1. 以下のコードを入力します。

    ```diff
      return (
        <div>
          <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
    +     <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
        </div>
      );
    ```

1. `Ctrl+S` でファイルを保存します。

1. 最終的なコードは以下のようになります。

    ```javascript
    import React from 'react';
    import * as microsoftTeams from '@microsoft/teams-js';
    import { Header, TextArea } from '@fluentui/react-northstar';
    import './App.css';

    const App: React.FC = () => {

      const [clientToken, setClientToken] = React.useState<string>();
      React.useEffect(() => {
        microsoftTeams.initialize();
        microsoftTeams.authentication.getAuthToken({
          successCallback: (token) => setClientToken(token),
          failureCallback: (error) => console.error(error)
        });
      }, []);

      return (
        <div>
          <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
          <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
        </div>
      );

    }

    export default App;
    ```

## 動作を確認する

1. メニュー バーの **実行** - **デバッグの開始** をクリックします。

1. Microsoft Teams にログインします。

1. `my-teams-app` のインストールを求められるので **追加** をクリックします。

1. テキスト エリアにシングル サインオンされたアクセス トークンが表示されることを確認します。

---

お疲れさまでした！次のセクションでは Microsoft Graph API を実行する方法を学習します。

[Microsoft Graph API を実行する](04_call-microsoft-graph-api.md)
