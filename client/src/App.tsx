import React from 'react';
import { Header } from '@fluentui/react-northstar';
import './App.css';

const App: React.FC = () => {

  return (
    <div>
      <Header align="center" as="h1" content="my-teams-app" description="Welcome to my first app!" />
    </div>
  );
}

export default App;
