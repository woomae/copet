"use client";

import React from "react";
import Image from "next/image";
import MainContainer from "@/components/common/MainContainer";
import Forum from "../../public/images/Forum.png";
import Chating from "../../public/images/Chating.png";

const ComunityLayout = () => {
  return (
    <MainContainer>
      <div className="m-auto basis-2/5 w-full flex md:flex-row flex-col">
        <div className="flex flex-col md:m-auto mt-20 text-3xl md:text-4xl">
          <h1 className="md:mr-24">소통을 위한</h1>
          <h1 className="md:ml-24">채팅과 게시판</h1>
        </div>
        <div className="m-auto">
          <Image src={Chating} alt="" width={286} height={31} />
        </div>
      </div>

      <div className="basis-3/5 flex flex-col md:flex-row pb-10 md:pb-40 my-3 md:my-0 mx-10 ">
        <div className="basis-2/5 flex flex-col items-center justify-center gap-5 mb-10">
          <div className="p-3 rounded-3xl rounded-bl-none bg-white shadow-2xl">
            <Image src={Forum} alt="" width={316} height={147} />
          </div>
          <div className="p-3 rounded-3xl rounded-bl-none bg-white shadow-2xl">
            <Image src={Forum} alt="" width={316} height={147} />
          </div>
        </div>
        <div className="h-full basis-3/5 text-m justify-center flex flex-col">
          <div className="flex flex-row m-auto">
            <span className="w-4/5">
              로렘 입숨(lorem ipsum; 줄여서 립숨, lipsum)은 출판이나 그래픽
              디자인 분야에서 폰트, 타이포그래피, 레이아웃 같은 그래픽 요소나
              시각적 연출을 보여줄 때 사용하는 표준 채우기 텍스트이다.{" "}
            </span>
          </div>
          <div className="flex flex-row-reverse m-auto">
            <span className="w-4/5">
              로렘 입숨(lorem ipsum; 줄여서 립숨, lipsum)은 출판이나 그래픽
              디자인 분야에서 폰트, 타이포그래피, 레이아웃 같은 그래픽 요소나
              시각적 연출을 보여줄 때 사용하는 표준 채우기 텍스트이다.{" "}
            </span>
          </div>
        </div>
      </div>
    </MainContainer>
  );
};

export default ComunityLayout;
