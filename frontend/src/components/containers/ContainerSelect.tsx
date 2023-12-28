import {Checkbox, ListItemText, MenuItem, Select} from "@mui/material";
import React from "react";

interface ContainerSelectProps {
    value: string[],
    onChange?: () => void,
    label: string,
    multiple: boolean,
    renderValue?: () => string
    values: string[],
    checkedCondition?: boolean
}

const ContainerSelect: React.FC<ContainerSelectProps> = ({value,
                                                             onChange,
                                                             label,
                                                             multiple,
                                                             renderValue,
                                                             values}) => {

   return <Select
            value={value}
            onChange={onChange}
            label={label}
            multiple={multiple}
            renderValue={renderValue}
        >
       {values.map(itemValue =>
           <MenuItem>
               <Checkbox value={itemValue}/>
               <ListItemText primary={itemValue}/>
           </MenuItem>
       )}
        </Select>;
}
export default ContainerSelect;