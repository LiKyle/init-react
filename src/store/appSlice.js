import axios from 'axios'
import { createSlice, createAsyncThunk } from '@reduxjs/toolkit'

const NAME = 'app'

const initialState = {
    count: 0
}

const thunkTest = createAsyncThunk(
    `${NAME}/thunkTest`,
    (payload, api) => axios.get('https://jsonplaceholder.typicode.com/todos/1')
        .then(resp => {
            return resp.data
        })
        .catch(error => { })
)

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
})

export default { ...slice.actions, thunkTest }
export const appReducer = slice.reducer

