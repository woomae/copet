import React, { ReactNode } from "react";

interface Props {
  children: ReactNode;
}
const MainContainer = ({ children }: Props) => {
  return (
    <div className="flex flex-col h-[95%] w-[90%] m-auto bg-gray-150">
      {children}
    </div>
  );
};

export default MainContainer;
