/*
  Warnings:

  - You are about to drop the `Event` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `ListName` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Price` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `SignedUser` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `accounts` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `sessions` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `verification_tokens` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Event" DROP CONSTRAINT "Event_user_id_fkey";

-- DropForeignKey
ALTER TABLE "ListName" DROP CONSTRAINT "ListName_eventId_fkey";

-- DropForeignKey
ALTER TABLE "ListName" DROP CONSTRAINT "ListName_priceId_fkey";

-- DropForeignKey
ALTER TABLE "ListName" DROP CONSTRAINT "ListName_userId_fkey";

-- DropForeignKey
ALTER TABLE "SignedUser" DROP CONSTRAINT "SignedUser_listNameId_fkey";

-- DropForeignKey
ALTER TABLE "accounts" DROP CONSTRAINT "accounts_userId_fkey";

-- DropForeignKey
ALTER TABLE "sessions" DROP CONSTRAINT "sessions_userId_fkey";

-- DropTable
DROP TABLE "Event";

-- DropTable
DROP TABLE "ListName";

-- DropTable
DROP TABLE "Price";

-- DropTable
DROP TABLE "SignedUser";

-- DropTable
DROP TABLE "accounts";

-- DropTable
DROP TABLE "sessions";

-- DropTable
DROP TABLE "verification_tokens";

-- CreateTable
CREATE TABLE "account" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "type" TEXT NOT NULL,
    "provider" TEXT NOT NULL,
    "providerAccountId" TEXT NOT NULL,
    "refresh_token" TEXT,
    "access_token" TEXT,
    "expires_at" INTEGER,
    "token_type" TEXT,
    "scope" TEXT,
    "id_token" TEXT,
    "session_state" TEXT,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "account_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "session" (
    "id" TEXT NOT NULL,
    "sessionToken" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "session_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "verification_token" (
    "identifier" TEXT NOT NULL,
    "token" TEXT NOT NULL,
    "expires" TIMESTAMP(3) NOT NULL
);

-- CreateTable
CREATE TABLE "event" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "user_id" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "event_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "list_name" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "size" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "url" TEXT NOT NULL,
    "eventId" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "priceId" TEXT NOT NULL,

    CONSTRAINT "list_name_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "signed_user" (
    "id" TEXT NOT NULL,
    "listNameId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "gender" "Gender" NOT NULL,
    "birthdate" TIMESTAMP(3) NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "status" "TicketStatus" NOT NULL,

    CONSTRAINT "signed_user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "price" (
    "id" TEXT NOT NULL,
    "value" DECIMAL(65,30) NOT NULL,
    "discount" DECIMAL(65,30) NOT NULL,
    "discountType" "BillingType" NOT NULL,
    "availableCommission" DECIMAL(65,30) NOT NULL,
    "commissionType" "BillingType" NOT NULL,

    CONSTRAINT "price_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "account_userId_idx" ON "account"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "account_provider_providerAccountId_key" ON "account"("provider", "providerAccountId");

-- CreateIndex
CREATE UNIQUE INDEX "session_sessionToken_key" ON "session"("sessionToken");

-- CreateIndex
CREATE INDEX "session_userId_idx" ON "session"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "verification_token_token_key" ON "verification_token"("token");

-- CreateIndex
CREATE UNIQUE INDEX "verification_token_identifier_token_key" ON "verification_token"("identifier", "token");

-- CreateIndex
CREATE UNIQUE INDEX "list_name_eventId_key" ON "list_name"("eventId");

-- CreateIndex
CREATE UNIQUE INDEX "list_name_userId_key" ON "list_name"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "list_name_priceId_key" ON "list_name"("priceId");

-- AddForeignKey
ALTER TABLE "account" ADD CONSTRAINT "account_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "session" ADD CONSTRAINT "session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "event" ADD CONSTRAINT "event_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_name" ADD CONSTRAINT "list_name_priceId_fkey" FOREIGN KEY ("priceId") REFERENCES "price"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_name" ADD CONSTRAINT "list_name_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "list_name" ADD CONSTRAINT "list_name_eventId_fkey" FOREIGN KEY ("eventId") REFERENCES "event"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "signed_user" ADD CONSTRAINT "signed_user_listNameId_fkey" FOREIGN KEY ("listNameId") REFERENCES "list_name"("id") ON DELETE CASCADE ON UPDATE CASCADE;
