import { configureStore, combineReducers } from "@reduxjs/toolkit";
import registrationReducer from "./reducers/registrationReducer";
import authReducer from "./reducers/authReducer";
import validationReducer from "./reducers/validationReducer";
import parameterReducer from "./reducers/parameterReducer";
import orderReducer from "./reducers/orderReducer";
import editOrderReducer from "./reducers/editOrderReducer";
import reportReducer from "./reducers/reportReducer";
import notificationReducer from "./reducers/notificationReducer";
import orderStateReducer from "./reducers/orderStateReducer";

const rootReducer = combineReducers({
  registration: registrationReducer,
  registrationValidations: validationReducer,
  currentUser: authReducer,
  serviceParams: parameterReducer,
  orderToCreate: orderReducer,
  editOrder: editOrderReducer,
  orderState: orderStateReducer,
  reportPeriod: reportReducer,
  notificationDisplay: notificationReducer
});

const store = configureStore({
  reducer: rootReducer,
});

export type RootState = ReturnType<typeof rootReducer>;

export default store;
