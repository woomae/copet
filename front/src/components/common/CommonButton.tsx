import React from "react";

interface Props {
  children: React.ReactNode;
  onClick?: () => void;
}
const CommonButton = ({ children, onClick }: Props) => {
  return (
    <button
      className="w-44 p-4 pb-4 bg-white m-2 ml-0 text-black rounded-2xl shadow-lg"
      onClick={onClick}
    >
      {children}
    </button>
  );
};

export default CommonButton;
