import React from 'react'
import ReactDOM from 'react-dom/client'
// Import all Bootstrap plugins
import * as bootstrap from 'bootstrap'

import { Provider } from 'react-redux'
import store from './store/store.js'

import { App } from './app'

const rootDiv = document.getElementById('app_root')
const root = ReactDOM.createRoot(rootDiv)
root.render(<Provider store={store}><App /></Provider>)

