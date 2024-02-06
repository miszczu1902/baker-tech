import {
  Checkbox,
  FormControl,
  MenuItem,
  Select,
} from "@mui/material";
import React from "react";
import _ from "lodash";
import { useTranslation } from "react-i18next";

interface ContainerSelectProps {
  onChange: (arg: any) => void;
  values: string[];
  renderValue: string;
  textLabels?: boolean;
}

const ContainerSelect: React.FC<ContainerSelectProps> = ({
  onChange,
  values,
  renderValue,
  textLabels
}) => {
  const { t } = useTranslation();

  return (
    <FormControl className="data-select-item">
      <Select
        multiple={false}
        value={values}
        onChange={onChange}
        renderValue={(selected) =>
          _.filter(selected, (item) => item === renderValue)
        }
      >
        {values &&
          values.map((itemValue) => (
            <MenuItem key={itemValue} value={itemValue}>
              <Checkbox checked={itemValue === renderValue} />
              {textLabels ? t(`months.${itemValue}`) : itemValue}
            </MenuItem>
          ))}
      </Select>
    </FormControl>
  );
};
export default ContainerSelect;
