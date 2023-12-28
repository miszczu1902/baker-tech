import {Box, TextField} from "@mui/material";
import React from "react";

export enum InputType {
    BASIC = 'basic',
    PASSWORD = 'password'
}

interface ContainerRowProps {
    placeholder: string;
    type: InputType;
    onChangeValue?: (event: React.ChangeEvent<HTMLInputElement>) => void;
    value?: string | number;
    valid?: boolean;
    validationText?: string;
}

const ContainerRow: React.FC<ContainerRowProps> = ({placeholder,
                                                       type,
                                                       onChangeValue,
                                                       value,
                                                       valid,
                                                   validationText}) => {
    return (
        <Box>
            <TextField
                variant="standard"
                label={placeholder}
                type={type}
                onChange={onChangeValue}
                value={value}
                className="data-container-row"
                helperText={(validationText && !valid) && validationText}
            />
        </Box>
    );
}
export default ContainerRow;