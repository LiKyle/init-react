import React, { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import { HashRouter, Routes, Route } from 'react-router-dom'

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
}
