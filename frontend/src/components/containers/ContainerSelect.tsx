import {MenuItem, Select} from "@mui/material";

const ContainerSelect = () => {
    return (<div>
        <Select
            labelId="demo-simple-select-standard-label"
            id="demo-simple-select-standard"
            value={"AAA"}
            onChange={() => console.log("A")}
            label="Age"
        >
            <MenuItem value={10}>Ten</MenuItem>
            <MenuItem value={20}>Twenty</MenuItem>
            <MenuItem value={30}>Thirty</MenuItem>
        </Select>
    </div>);
}
export default ContainerSelect;