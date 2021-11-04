[目次に戻る](README.md#目次)

# Teams アプリを作成する

作成したアプリを Microsoft Teams で表示できるようにするためには Microsoft Teams でアプリを登録する必要があります。

## アプリを作成する

1. [**Teams 開発者ポータル**](https://dev.teams.microsoft.com) にログインします。

1. アプリ バーの **Apps** をクリックします。

1. **New app** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |Name|`my-teams-app`|

1. **Add** をクリックします。

## アプリの基本情報を設定する

1. **Basic information** で以下の項目を入力します。

    |カテゴリー|項目|値|
    |-|-|-|
    |Descriptions|Short description|`my-teams-app`|
    ||Long description|`my-teams-app`|
    |Developer information|Developer or company name|`my-teams-app`|
    ||Website|`https://localhost:3000`|
    |App URLs|Privacy policy|`https://localhost:3000`|
    ||Terms of use|`https://localhost:3000`|

1. **Save** をクリックします。

### アプリの個人用タブを構成する

1. **App features** をクリックします。

1. **Personal App** をクリックします。

1. **Create your first personal app tab** をクリックします。

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |Name|`Home`|
    |Entity ID|(既定値)|
    |Content URL|`https://localhost:3000`|
    |Website URL|`https://localhost:3000`|

1. **Save** をクリックします。

1. **App ID** をメモ帳などにコピーします。

## アプリをインストールする

1. **Preview in Teams** をクリックします。

1. 新しいタブで **代わりに Web アプリを使用** をクリックします。

1. **追加** をクリックします。

1. ページが Microsoft Teams のタブとして表示されることを確認します。

---

お疲れさまでした！次のセクションでは作成したアプリにシングル サインオンを実装する方法を学習します。

[シングル サインオンを実装する](03_imprement-single-sign-on.md)
