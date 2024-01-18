"use client";

import React from "react";
import Image from "next/image";
import MapImage from "../../public/images/Map.png";
import MainContainer from "@/components/common/MainContainer";

const MapLayout = () => {
  return (
    <MainContainer>
      <div className="flex flex-col md:flex-row w-full items-center justify-center">
        <div className="basis-1/2 mb-10">
          <div className="rotate-[330deg]">
            <Image src={MapImage} alt="" width={367.49} height={769.72} />
          </div>
        </div>
        <div className="basis-1/2 m-auto items-center justify-center text-right">
          <h1 className="text-4xl my-5">지도 기능</h1>
          <h2 className="text-l">
            로렘 입숨(lorem ipsum; 줄여서 립숨, lipsum)은 출판이나 그래픽 디자인
            분야에서 폰트, 타이포그래피, 레이아웃 같은 그래픽 요소나 시각적
            연출을 보여줄 때 사용하는 표준 채우기 텍스트이다.
          </h2>
        </div>
      </div>
    </MainContainer>
  );
};

export default MapLayout;
