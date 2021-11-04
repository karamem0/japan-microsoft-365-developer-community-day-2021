[目次に戻る](README.md#目次)

# Microsoft Graph API を実行する

シングル サインオンで取得したアクセス トークンでは Microsoft Graph をはじめとした他のサービスの API を呼び出すためのアクセス許可がありません。API を呼び出すためにはアクセス トークンを変換する必要があります。

## C# プロジェクトを作成する

セキュリティの理由により、アクセス トークンの変換はクライアントでは行うことができず、サーバーで実施する必要があります。TeamsFx で提供されている Simple Auth を使ってサーバーを実装します。

1. `server` フォルダーで以下のコマンドを実行します。

    ```cmd
    dotnet new webapi --framework netcoreapp3.1 --name MyTeamsApp --output .
    ```

1. `server` フォルダーで以下のコマンドを実行します。

    ```cmd
    dotnet add package Microsoft.TeamsFx.SimpleAuth --version 0.1.0
    ```

## C# プロジェクトのコードを修正する

### Visual Studio Code でプロジェクトを開く

1. Visual Studio Code を起動します。

1. メニュー バーの **ファイル** - **フォルダーを開く** から `server` フォルダーを開きます。

### Startup.cs を修正する

1. `Startup.cs` を開きます。

1. 以下のコードを入力します。

    ```diff
      using System;
      using System.Collections.Generic;
      using System.Linq;
      using System.Threading.Tasks;
      using Microsoft.AspNetCore.Builder;
      using Microsoft.AspNetCore.Hosting;
      using Microsoft.AspNetCore.HttpsPolicy;
      using Microsoft.AspNetCore.Mvc;
      using Microsoft.Extensions.Configuration;
      using Microsoft.Extensions.DependencyInjection;
      using Microsoft.Extensions.Hosting;
      using Microsoft.Extensions.Logging;
    + using Microsoft.TeamsFx.SimpleAuth;
    ```

1. 以下のコードを入力します。

    ```diff
      public void ConfigureServices(IServiceCollection services)
      {
          services.AddControllers();

    +     services.AddTeamsFxSimpleAuth(Configuration);

    +     services.AddCors(options =>
    +     {
    +         options.AddDefaultPolicy(builder =>
    +         {
    +             builder
    +                 .AllowAnyOrigin()
    +                 .AllowAnyHeader()
    +                 .AllowAnyMethod();
    +         });
    +     });
      }
    ```

1. 以下のコードを入力します。

    ```diff
      public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
      {
          if (env.IsDevelopment())
          {
              app.UseDeveloperExceptionPage();
          }

          app.UseHttpsRedirection();

          app.UseRouting();

    +     app.UseCors();

          app.UseAuthorization();

          app.UseAuthorization();

          app.UseEndpoints(endpoints =>
          {
              endpoints.MapControllers();
          });
      }
    ```

1. `Ctrl+S` でファイルを保存します。

1. 最終的なコードは以下のようになります。

    ```csharp
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    using Microsoft.AspNetCore.Builder;
    using Microsoft.AspNetCore.Hosting;
    using Microsoft.AspNetCore.HttpsPolicy;
    using Microsoft.AspNetCore.Mvc;
    using Microsoft.Extensions.Configuration;
    using Microsoft.Extensions.DependencyInjection;
    using Microsoft.Extensions.Hosting;
    using Microsoft.Extensions.Logging;
    using Microsoft.TeamsFx.SimpleAuth;

    namespace MyTeamsApp
    {
        public class Startup
        {
            public Startup(IConfiguration configuration)
            {
                Configuration = configuration;
            }

            public IConfiguration Configuration { get; }

            // This method gets called by the runtime. Use this method to add services to the container.
            public void ConfigureServices(IServiceCollection services)
            {
                services.AddControllers();

                services.AddTeamsFxSimpleAuth(Configuration);

                services.AddCors(options =>
                {
                    options.AddDefaultPolicy(builder =>
                    {
                        builder
                            .AllowAnyOrigin()
                            .AllowAnyHeader()
                            .AllowAnyMethod();
                    });
                });
            }

            // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
            public void Configure(IApplicationBuilder app, IWebHostEnvironment env)
            {
                if (env.IsDevelopment())
                {
                    app.UseDeveloperExceptionPage();
                }

                app.UseHttpsRedirection();

                app.UseRouting();

                app.UseCors();

                app.UseAuthorization();

                app.UseEndpoints(endpoints =>
                {
                    endpoints.MapControllers();
                });
            }
        }
    }
    ```

### appsettings.json を修正する

1. `appsettings.json` を開きます。

1. 以下のコードを入力します。

    ```diff
      {
          "Logging": {
              "LogLevel": {
                  "Default": "Information",
                  "Microsoft": "Warning",
                  "Microsoft.Hosting.Lifetime": "Information"
              }
          },
    -     "AllowedHosts": "*"
    +     "AllowedHosts": "*",
    +     "CLIENT_ID": "",
    +     "CLIENT_SECRET": "",
    +     "IDENTIFIER_URI": "",
    +     "OAUTH_AUTHORITY": "",
    +     "AAD_METADATA_ADDRESS": "",
    +     "ALLOWED_APP_IDS": "",
    +     "TAB_APP_ENDPOINT": ""
      }
    ```

1. 以下の項目を入力します。

    |項目|値|
    |-|-|
    |CLIENT_ID|`{client_id}`|
    |CLIENT_SECRET|`{client_secret}`|
    |IDENTIFIER_URI|`api://localhost:3000/{client_id}`|
    |OAUTH_AUTHORITY|`https://login.microsoftonline.com/{tenant_id}`|
    |AAD_METADATA_ADDRESS|`https://login.microsoftonline.com/{tenant_id}/.well-known/openid-configuration`|
    |ALLOWED_APP_IDS|`1fec8e78-bce4-4aaf-ab1b-5451cc387264;5e3ce6c0-2b1f-4285-8d4b-75ee78787346`|
    |TAB_APP_ENDPOINT|`https://localhost:3000`|

1. `Ctrl+S` でファイルを保存します。

## C# プロジェクトを実行する

1. `server` フォルダーで以下のコマンドを実行します。

    ```cmd
    dotnet run
    ```

1. ブラウザーで `https://localhost:5001/WeatherForecast` にアクセスできることを確認します。セキュリティの警告が出る場合は以下の手順で証明書をインストールします。

    1. 以下のコマンドを実行します。

        ```
        dotnet dev-certs https --trust
        ```

    1. 証明書のインストールのダイアログで **はい** をクリックします。

    1. 開いているブラウザーがある場合はすべて閉じます。


1. `server` フォルダーで以下の PowerShell を実行します。`{access_token}` には前のセクションで取得したシングル サインオンされたアクセス トークンを指定します。

    ```ps1
    ./test-token-exchange.ps1 {access_token}
    ```

1. 以下のように表示されることを確認します。

    ```
    scope        : User.Read profile openid email
    expires_on   : 2021-12-31T12:00:00+00:00
    access_token : eyJ0eXAi...
    ```

## React プロジェクトのコードを修正する

### App.tsx を修正する

1. `src/App.tsx` を開きます。

1. 以下のコードを入力します。

    ```diff
    + const [serverToken, setServerToken] = React.useState<string>();
    + React.useEffect(() => {
    +   if (clientToken) {
    +     (async () => {
    +       const response = await fetch(
    +         'https://localhost:5001/auth/token',
    +         {
    +           method: 'POST',
    +           headers: {
    +             Authorization: `Bearer ${clientToken}`,
    +             'Content-Type': 'application/json'
    +           },
    +           body: JSON.stringify({
    +             scope: 'User.Read',
    +             grant_type: 'sso_token'
    +           }),
    +           mode: 'cors'
    +         });
    +       const json = await response.json();
    +       setServerToken(json.access_token);
    +     })();
    +   }
    + }, [clientToken]);
    ```

1. 以下のコードを入力します。

    ```diff
      <div>
        <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
        <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
    +   <TextArea fluid inverted style={{ height: '12rem' }} value={serverToken} />
      </div>
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

      const [serverToken, setServerToken] = React.useState<string>();
      React.useEffect(() => {
        if (clientToken) {
          (async () => {
            const response = await fetch(
              'https://localhost:5001/auth/token',
              {
                method: 'POST',
                headers: {
                Authorization: `Bearer ${clientToken}`,
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                  scope: 'User.Read',
                  grant_type: 'sso_token'
                }),
                mode: 'cors'
            });
            const json = await response.json();
            setServerToken(json.access_token);
          })();
        }
      }, [clientToken]);

      return (
        <div>
          <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
          <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
          <TextArea fluid inverted style={{ height: '12rem' }} value={serverToken} />
        </div>
      );

    }

    export default App;
    ```

1. Teams アプリを表示します。(ホット リロードがうまく動作しない場合は `F5` キーで更新してください。) テキスト エリアに変換されたアクセス トークンが表示されることを確認します。

## 動作を確認する

Microsoft Graph API をダイレクトに実行してもいいですが、ここでは Microsoft Graph Toolkit を使って簡単に呼び出します。

### App.tsx を修正する

1. `src/App.tsx` を開きます。

1. 以下のコードを入力します。

    ```diff
      import React from 'react';
      import * as microsoftTeams from '@microsoft/teams-js';
      import { Header, TextArea } from '@fluentui/react-northstar';
    + import { Providers, ProviderState, SimpleProvider, Person, PersonViewType } from '@microsoft/mgt-react';
      import './App.css';
    ```

1. 以下のコードを入力します。

    ```diff
    + React.useEffect(() => {
    +   if (serverToken) {
    +   Providers.globalProvider = new SimpleProvider(
    +     () => Promise.resolve(serverToken)
    +   );
    +   Providers.globalProvider.setState(ProviderState.SignedIn);
    +   }
    + }, [serverToken]);
    ```

1. 以下のコードを入力します。
    ```diff
      return (
        <div>
          <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
    +     <Person personQuery="me" view={PersonViewType.twolines} />
          <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
          <TextArea fluid inverted style={{ height: '12rem' }} value={serverToken} />
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
    import { Providers, ProviderState, SimpleProvider, Person, PersonViewType } from '@microsoft/mgt-react';

    const App: React.FC = () => {

      const [clientToken, setClientToken] = React.useState<string>();
      React.useEffect(() => {
        microsoftTeams.initialize();
        microsoftTeams.authentication.getAuthToken({
          successCallback: (token) => setClientToken(token),
          failureCallback: (error) => console.error(error)
        });
      }, []);

      const [serverToken, setServerToken] = React.useState<string>();
      React.useEffect(() => {
        if (clientToken) {
          (async () => {
            const response = await fetch(
              'https://localhost:5001/auth/token',
              {
                method: 'POST',
                headers: {
                  Authorization: `Bearer ${clientToken}`,
                  'Content-Type': 'application/json'
                },
                body: JSON.stringify({
                  scope: 'User.Read',
                  grant_type: 'sso_token'
                }),
                mode: 'cors'
              });
            const json = await response.json();
            setServerToken(json.access_token);
          })();
        }
      }, [clientToken]);

      React.useEffect(() => {
        if (serverToken) {
          Providers.globalProvider = new SimpleProvider(
            () => Promise.resolve(serverToken)
          );
          Providers.globalProvider.setState(ProviderState.SignedIn);
        }
      }, [serverToken]);

      return (
        <div>
          <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
          <Person personQuery="me" view={PersonViewType.twolines} />
          <TextArea fluid inverted style={{ height: '12rem' }} value={clientToken} />
          <TextArea fluid inverted style={{ height: '12rem' }} value={serverToken} />
        </div>
      );

    }

    export default App;
    ```

1. Teams アプリを表示します。(ホット リロードがうまく動作しない場合は `F5` キーで更新してください。) 自身の名前とアイコン (設定されていれば) が表示されることを確認します。

---

お疲れさまでした！次のセクションでは Microsoft Teams のテーマを適用する方法を学習します。

[テーマを適用する](05_apply-theme.md)
