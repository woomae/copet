import React from "react";

interface Props {
  onClick?: () => void;
  isSelected: boolean;
}
const ScrollButton = ({ onClick, isSelected }: Props) => {
  return (
    <>
      <button
        className={`${
          isSelected ? "bg-gray-400 border-gary-400" : ""
        }"w-6 min-w-2 h-2 m-2 md:w-4 md:h-4 md:m-2 rounded-full border-2 border-gray-400 "`}
        onClick={onClick}
      ></button>
    </>
  );
};

export default ScrollButton;
