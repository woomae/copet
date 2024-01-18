export default function Footer() {
  return (
    <footer role="contentinfo" className="z-10 m-0 w-vw">
      <div className="m-0 md:h-40 flex flex-col items-center bg-gray-100">
        <div className="mt-3 flex space-x-4">내용</div>
        <div className="mt-3 flex space-x-2 text-sm text-gray-500 dark:text-gray-400">
          <div>SCNU</div>
          <div>{` • `}</div>
          <div>{`© ${new Date().getFullYear()}`}</div>
          <div>{` • `}</div>
          <div>COPET</div>
        </div>
        <div className="mb-8 text-sm text-gray-500 dark:text-gray-400">
          Copyright © COPET All Right Reserved.
        </div>
      </div>
    </footer>
  );
}
