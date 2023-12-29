import SectionContainer from "@/components/common/SectionContainer";

export default function Home() {
  return (
    <div className="p-0 flex flex-col bg-gray-200 mx-auto">
      <SectionContainer>
        <h1 className="m-auto text-white">p1</h1>
      </SectionContainer>
      <SectionContainer>
        <h1 className="m-auto text-white">p2</h1>
      </SectionContainer>
    </div>
  );
}
