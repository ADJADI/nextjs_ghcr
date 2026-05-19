import { NextResponse } from "next/server";

export async function GET() {
  return NextResponse.json({
    message: "Hello from Next.js!",
    version: process.env.NEXT_PUBLIC_APP_VERSION ?? "development",
    timestamp: new Date().toISOString(),
  });
}
