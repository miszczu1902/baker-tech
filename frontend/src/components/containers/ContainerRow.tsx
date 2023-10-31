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
    value?: string;
}

const ContainerRow: React.FC<ContainerRowProps> = ({placeholder, type, onChangeValue, value}) => {
    return (
        <Box>
            <TextField
                variant="standard"
                label={placeholder}
                type={type}
                onChange={onChangeValue}
                value={value}
                className="data-container-row"
            />
        </Box>
    );
}
export default ContainerRow;