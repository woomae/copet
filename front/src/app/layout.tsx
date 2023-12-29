import type { Metadata } from "next";
import "@/styles/tailwind.css";
import Footer from "@/components/Footer";

export const metadata: Metadata = {
  title: "Copet",
  description: "test",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="body">{children}</body>
      <Footer />
    </html>
  );
}
