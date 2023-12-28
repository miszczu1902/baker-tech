import {configureStore, combineReducers} from '@reduxjs/toolkit';
import registrationReducer from './reducers/registrationReducer';
import authReducer from "./reducers/authReducer";
import validationReducer from "./reducers/validationReducer";

const rootReducer = combineReducers({
    registration: registrationReducer,
    registrationValidations: validationReducer,
    currentUser: authReducer
});

const store = configureStore({
    reducer: rootReducer,
});

export type RootState = ReturnType<typeof rootReducer>;

export default store;