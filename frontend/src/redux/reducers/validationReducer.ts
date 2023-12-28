import {
    SET_FIRST_PAGE_REGISTRATION_STATUS,
    SET_SECOND_PAGE_REGISTRATION_STATUS,
    SET_THIRD_PAGE_REGISTRATION_STATUS
} from "../actions/actions";
import {RegistrationValidationPages} from "../../types/registration/RegistrationValidationPages";

const initialState: RegistrationValidationPages = {
    firstPage: false,
    secondPage: false,
    thirdPage: false
}

const validationReducer = (state = initialState, action: any) => {
    switch (action.type) {
        case SET_FIRST_PAGE_REGISTRATION_STATUS:
            return {
                ...state,
                ...action.payload
            }
        case SET_SECOND_PAGE_REGISTRATION_STATUS:
            return {
                ...state,
                ...action.payload
            }
        case SET_THIRD_PAGE_REGISTRATION_STATUS:
            return {
                ...state,
                ...action.payload
            }
        default:
            return state;
    }
}

export default validationReducer;