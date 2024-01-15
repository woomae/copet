import { MutableRefObject, useEffect, useState } from "react";

export const useScroll = (layoutRefs: MutableRefObject<HTMLElement[]>) => {
  const [isScrolling, setIsScrolling] = useState<boolean>(false);
  const [currentLayout, setCurrentLayout] = useState<number>(0);

  //isScrolling 기본값 true. 재랜더링 되어도 true. 첫 랜더링 시에만 false.
  //첫 스크롤 시 handleScroll 실행, isScrolling true로 변경되며 스크롤 방지 및 useEffect 재실행.
  const handleScroll = (e: WheelEvent) => {
    console.log(layoutRefs.current.length - 1);
    if (isScrolling === false) {
      if (e.deltaY > 0 && currentLayout !== layoutRefs.current.length - 1) {
        setCurrentLayout(currentLayout + 1);
        layoutRefs.current[currentLayout + 1]?.scrollIntoView({
          behavior: "smooth",
        });
      }
      if (e.deltaY < 0 && currentLayout !== 0) {
        setCurrentLayout(currentLayout - 1);
        layoutRefs.current[currentLayout - 1]?.scrollIntoView({
          behavior: "smooth",
        });
      }
    }
    setIsScrolling(true);
    window.removeEventListener("wheel", handleScroll);
  };

  useEffect(() => {
    const timer = setTimeout(() => {
      setIsScrolling(false);
      window.addEventListener("wheel", handleScroll);
    }, 1400);
    //휠 이벤트 발생 시 중복 타이머 제거
    if (isScrolling === false) {
      clearTimeout(timer);
    }
    return () => {
      clearTimeout(timer);
      window.addEventListener("wheel", handleScroll);
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [isScrolling]);

  return { isScrolling, setIsScrolling, currentLayout, setCurrentLayout };
};
