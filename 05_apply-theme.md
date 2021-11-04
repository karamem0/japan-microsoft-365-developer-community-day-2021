[目次に戻る](README.md#目次)

# テーマを適用する

Microsoft Teams では `既定`、`ダーク`、`ハイ コントラスト` のテーマを選ぶことができますが、アプリもテーマにしたがって表示するとユーザー体験が向上します。

## React プロジェクトのコードを修正する

### ThemeProvider.tsx を作成する

1. `src` を右クリックし **新しいファイル** をクリックします。

1. ファイル名を `ThemeProvider.tsx` に設定します。

1. 以下のコードを入力します。

    ```javascript
    import React from 'react';
    import * as microsoftTeams from '@microsoft/teams-js';
    import { Provider, ThemePrepared, teamsV2Theme, teamsDarkV2Theme, teamsHighContrastTheme } from '@fluentui/react-northstar';

    const ThemeProvider: React.FC = ({ children }) => {

      const onThemeChange = (name?: string) => {
        switch (name) {
          case 'dark':
            setTheme(teamsDarkV2Theme);
            break;
          case 'contrast':
            setTheme(teamsHighContrastTheme);
            break;
          default:
            setTheme(teamsV2Theme);
            break;
        }
      };

      const [theme, setTheme] = React.useState<ThemePrepared>();
      React.useEffect(() => {
        microsoftTeams.initialize();
        microsoftTeams.getContext((context) => {
          onThemeChange(context.theme)
        });
        microsoftTeams.registerOnThemeChangeHandler((name) => {
          onThemeChange(name);
        });
      }, []);

      return (
        theme
          ? (
            <Provider theme={theme}>
              {children}
            </Provider>
          )
          : null
      );

    };

    export default ThemeProvider;
    ```

1. `Ctrl+S` でファイルを保存します。

### index.tsx を作成する

1. `src/index.tsx` を開きます。

1. 以下のコードを入力します。

    ```diff
    import React from 'react';
    import ReactDOM from 'react-dom';
    - import { Provider, teamsV2Theme } from '@fluentui/react-northstar';
    + import ThemeProvider from './ThemeProvider';
    import './index.css';
    import App from './App';
    ```

1. 以下のコードを入力します。

    ```diff
      ReactDOM.render(
        (
    -     <Provider theme={teamsV2Theme}>
    +     <ThemeProvider>
            <App />
    -     </Provider>
    +     </ThemeProvider>
        ),
        document.getElementById('root')
      );
    ```

1. `Ctrl+S` でファイルを保存します。

1. 最終的なコードは以下のようになります。

    ```javascript
    import React from 'react';
    import ReactDOM from 'react-dom';
    import ThemeProvider from './ThemeProviderContext';
    import './index.css';
    import App from './App';

    ReactDOM.render(
      (
        <ThemeProvider>
          <App />
        </ThemeProvider>
      ),
      document.getElementById('root')
    );
    ```

## 動作を確認する

1. Teams アプリを表示します。(ホット リロードがうまく動作しない場合は `F5` キーで更新してください。)

1. **...** - **設定** をクリックします。

1. **テーマ** を `ダーク` に変更します。

1. Teams アプリがダーク モードになっていることを確認します。

1. 同様に `ハイ コントラスト` でもテーマが適用されていることを確認します。

---

お疲れさまでした！以上でハンズオンは終了です。
