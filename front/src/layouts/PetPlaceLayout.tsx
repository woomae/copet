"use client";

import MainContainer from "@/components/common/MainContainer";
import React from "react";
import Image from "next/image";
import petPlacePhone from "../../public/images/PetPlacePhone.png";

const PetPlaceLayout = () => {
  return (
    <MainContainer>
      <div className="m-auto m-0 w-full flex flex-col md:flex-row md:mx-auto">
        <div className="my-auto mx-0 w-full text-left">
          <h1 className="text-4xl my-5">펫플레이스</h1>
          <h2 className="text-l md:text-xl">
            로렘 입숨(lorem ipsum; 줄여서 립숨, lipsum)은 출판이나 그래픽 디자인
            분야에서 폰트, 타이포그래피, 레이아웃 같은 그래픽 요소나 시각적
            연출을 보여줄 때 사용하는 표준 채우기 텍스트이다.
          </h2>
        </div>
        <div className="mr-16 md:w-full flex flex-row-reverse">
          <Image src={petPlacePhone} alt="" width={367.49} height={769.72} />
        </div>
      </div>
    </MainContainer>
  );
};

export default PetPlaceLayout;
