import React from 'react';
import ReactDOM from 'react-dom';
import { Provider, teamsV2Theme } from '@fluentui/react-northstar';
import './index.css';
import App from './App';

ReactDOM.render(
  (
    <Provider theme={teamsV2Theme}>
      <App />
    </Provider>
  ),
  document.getElementById('root')
);
