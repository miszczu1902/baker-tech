import { Box, TextField } from "@mui/material";
import React from "react";

export enum InputType {
  BASIC = "basic",
  PASSWORD = "password",
  NUMERICAL = "number",
}

interface ContainerRowProps {
  className?: string;
  placeholder: string;
  type: InputType;
  onChangeValue?: (event: React.ChangeEvent<HTMLInputElement>) => void;
  value?: string | number | boolean;
  valid?: boolean;
  validationText?: string;
}

const ContainerRow: React.FC<ContainerRowProps> = ({
  className,
  placeholder,
  type,
  onChangeValue,
  value,
  valid,
  validationText,
}) => {
  return (
    <Box>
      <TextField
        variant="standard"
        label={placeholder}
        type={type}
        onChange={onChangeValue}
        value={value}
        className={className ? className : "data-container-row"}
        helperText={validationText && !valid && validationText}
      />
    </Box>
  );
};
export default ContainerRow;
