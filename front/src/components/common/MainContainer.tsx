import React, { ReactNode } from "react";

interface Props {
  children: ReactNode;
}
const MainContainer = ({ children }: Props) => {
  return (
    <div className="flex flex-col h-full w-[80%] m-0 p-0 items-center justify-center">
      {children}
    </div>
  );
};

export default MainContainer;
