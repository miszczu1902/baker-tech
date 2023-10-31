import {configureStore, combineReducers} from '@reduxjs/toolkit';
import registrationReducer from './reducers/registrationReducer';

const rootReducer = combineReducers({
    registration: registrationReducer,
});

const store = configureStore({
    reducer: rootReducer,
});

export type RootState = ReturnType<typeof rootReducer>;

export default store;