import type { Metadata } from "next";
import "@/styles/tailwind.css";
import { Noto_Sans_KR } from "next/font/google";

export const metadata: Metadata = {
  title: "Copet",
  description: "test",
};

const notoSansKr = Noto_Sans_KR({
  weight: ["500"],
  subsets: ["latin"],
  variable: "--noto-sans-kr",
});
export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en" className={`${notoSansKr.className}`}>
      <body className="m-0 overflow-y-hidden">
        <main className="overflow-y-hidden">{children}</main>
      </body>
    </html>
  );
}
