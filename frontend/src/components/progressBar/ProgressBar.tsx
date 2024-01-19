import { LinearProgress } from "@mui/material";
import React from "react";

interface ProgressBarProps {
  progress: number;
}

const ProgressBar: React.FC<ProgressBarProps> = ({ progress }) => {
  return (
    <LinearProgress
      className="progress-bar"
      variant="determinate"
      value={progress}
    />
  );
};
export default ProgressBar;
