import {Button} from "@mui/material";
import {useLocation, useNavigate} from "react-router-dom";
import React from "react";

interface BasicButtonProps {
    content: string; 
    path?: string; 
    onClick?: () => void;
}
const BasicButton: React.FC<BasicButtonProps> = ({content, path, onClick}) => {
    const navigate = useNavigate();
    const location = useLocation();

    const handleButtonClick = () => {
        onClick ? onClick() : (path ? navigate(path) : navigate(location.pathname));
    }

    return (
        <Button
            className="basic-button"
            variant="contained"
            onClick={handleButtonClick}
        >
            {content}
        </Button>
    );
};
export default BasicButton;
