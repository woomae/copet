"use client";

import MainContainer from "@/components/common/MainContainer";
import React from "react";

interface Props {
  onClick: () => void;
}
const MainLayout = ({ onClick }: Props) => {
  return (
    <MainContainer>
      <div className="mt-40 text-center">
        <h1 className="text-5xl font-bold m-auto items-center">COPET</h1>
        <h2 className="m-auto text-3xl">
          홍보용 문구
          <br />
          제품 설명
        </h2>
      </div>
      <button
        className="w-64 p-4 pb-4 m-auto  bg-white text-black rounded-2xl shadow-lg"
        onClick={onClick}
      >
        지금 시작하기
      </button>
    </MainContainer>
  );
};

export default MainLayout;
