# MIT License
# Copyright (c) 2022 Kyle Li

mkdir src
mkdir src/global
mkdir src/store
mkdir src/page

npm i -D parcel
npm i react react-dom react-router-dom \
    @reduxjs/toolkit react-redux moment axios \
    bootstrap bootstrap-icons sweetalert2 \
    styled-components

echo '/node_modules/
/dist/
/build/
/.parcel-cache/
.DS_Store' >> .gitignore

echo "import axios from 'axios'
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'\n
const NAME = 'app'\n
const initialState = {
    count: 0
}\n
const thunkTest = createAsyncThunk(
    \`\${NAME}/thunkTest\`,
    (payload, api) => axios.get('https://jsonplaceholder.typicode.com/todos/1')
        .then(resp => {
            return resp.data
        })
        .catch(error => { })
)\n
export const slice = createSlice({
    name: NAME,
    initialState: initialState,
    reducers: {
        setCount: (state, action) => {
            state.count = action.payload
        },
    }, extraReducers: (builder) => {
        builder
            .addCase(thunkTest.fulfilled, (state, action) => {
                console.log(action.payload)
            })
    }
})\n
export default { ...slice.actions, thunkTest }
export const appReducer = slice.reducer
" >> src/store/appSlice.js

echo "import { configureStore } from '@reduxjs/toolkit'
import { appReducer } from './appSlice'\n
const store = configureStore({
    reducer: {
        app: appReducer
    },
})\n
export default store
" >> src/store/store.js

echo "import React, { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import { HashRouter, Routes, Route } from 'react-router-dom'\n
export function App() {
    const disp = useDispatch()
    useEffect(() => {
    }, [])
    return (
        <>
            <HashRouter>
                <Routes>
                    <Route path='' element={<div>Hello World</div>} />
                </Routes>
            </HashRouter>
        </>
    )
}" >> src/App.js

echo "import React from 'react'
import ReactDOM from 'react-dom/client'
// Import all Bootstrap plugins
import * as bootstrap from 'bootstrap'\n
import { Provider } from 'react-redux'
import store from './store/store.js'\n
import { App } from './app'\n
const rootDiv = document.getElementById('app_root')
const root = ReactDOM.createRoot(rootDiv)
root.render(<Provider store={store}><App /></Provider>)
" >> src/index.js

echo '<!doctype html>
<html lang="en">\n
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Title</title>
  <link rel="stylesheet" href="index.scss" />
  <script type="module" src="index.js"></script>
</head>\n
<body>
  <div id="app_root"></div>
</body>\n
</html>' >> src/index.html

echo '/* Customize Bootstrap parameters, such as Modal max-width */
$modal-lg: 930px;
$modal-xl: 1280px;\n
/* import Bootstrap */
@import "../node_modules/bootstrap/scss/bootstrap";
' >> src/index.scss

echo '{
    "compilerOptions": {
        "baseUrl": "./src",
        "checkJs": true,
        "jsx": "react",
        "lib": [
            "dom",
            "esnext",
            "es2015.promise"
        ],
    }
}' >> jsconfig.json

echo '
Add the following 2 lines to the "scripts" section of packge.json:
  "start": "parcel src/index.html",
  "build": "parcel build --no-source-maps --dist-dir build src/index.html",

Remove the next line from package.json:
  "main": "index.js",

Command:
  npm start -> Start dev mode
  npm run build -> Build the project to production
'
