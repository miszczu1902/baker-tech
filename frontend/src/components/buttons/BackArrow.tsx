import {ArrowBackIosNew} from "@mui/icons-material";
import React from "react";
import {ArrowProps} from "./types/ArrowProps";

const BackArrow: React.FC<ArrowProps> = ({className, onClick}) => {
    return <ArrowBackIosNew className={className ? className : "arrow"} onClick={onClick}/>
}
export default BackArrow;