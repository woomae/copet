export default function Footer() {
  return (
    <footer role="contentinfo">
      <div className="m-0 flex flex-col items-center bg-gray-100">
        <div className="mt-3 flex space-x-4">내용</div>
        <div className="mt-3 flex space-x-2 text-sm text-gray-500 dark:text-gray-400">
          <div>{` • `}</div>
          <div>{`© ${new Date().getFullYear()}`}</div>
          <div>{` • `}</div>
          <div>COPET</div>
        </div>
        <div className="mb-8 text-sm text-gray-500 dark:text-gray-400"></div>
      </div>
    </footer>
  );
}
