import _ from "lodash";

export const validateUsername = (username: string): boolean => {
    return /^[^\s]{5,32}$/.test(username) && _.size((username)) > 0;
}

export const validateEmail = (email: string): boolean => {
    return /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Z|a-z]{2,}$/.test(email) && _.size(email) > 0;
}

export const validateFirstname = (firstname: string): boolean => {
    return /^[^\s]{1,32}$/.test(firstname) && _.size(firstname) > 0;
}

export const validateLastname = (lastname: string): boolean => {
    return /^[^\s]{1,32}$/.test(lastname) && _.size(lastname) > 0;
}

export const validatePassword = (password: string): boolean => {
    return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@#$%^&+=!])([a-zA-Z\d@#$%^&+=!]{8,})$/.test(password)
        && _.size((password)) > 0;
}

export const validateConfirmPassword = (password: string, confirmPassword: string): boolean => {
    return validatePassword(password) && (confirmPassword === password);
}

export const validateCompanyName = (companyName: string): boolean => {
    return /^.{2,64}$/.test(companyName) && _.size((companyName)) > 0;
}

export const validatePhoneNumber = (phoneNumber: string): boolean => {
    return /^(?:\+\d{1,3}\s?)?(?:\d{3,4})?\d{6,10}$/.test(phoneNumber) && _.size((phoneNumber)) > 0;
}

export const validateNipNumber = (nip: string | number): boolean => {
    return /^\d{10}$/.test(nip as string) && _.size((nip.toString())) > 0;
}

export const validateRegonNumber = (regon: string | number): boolean => {
    return /^(?:\d{9}|\d{14}|\d{18})$/.test(regon as string) && _.size((regon.toString())) > 0;
}

export const validateStreet = (street: string): boolean => {
    return /^.{1,32}$/.test(street) && _.size((street)) > 0;
}

export const validateStreetNumber = (streetNumber: string): boolean => {
    return /^[0-9]+[A-Z]*$/.test(streetNumber) && _.size((streetNumber)) > 0;
}

export const validatePostalCode = (postalCode: string): boolean => {
    return /^\d{2}-\d{3}$/.test(postalCode) && _.size((postalCode)) > 0;
}

export const validateCity = (city: string): boolean => {
    return /^.{1,32}$/.test(city) && _.size((city)) > 0;
}