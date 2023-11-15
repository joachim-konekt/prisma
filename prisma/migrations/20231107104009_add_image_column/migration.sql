-- CreateEnum
CREATE TYPE "EnergyUnit" AS ENUM ('KWH', 'MWH', 'GJ');

-- CreateEnum
CREATE TYPE "VolumeUnit" AS ENUM ('NM3', 'L');

-- CreateEnum
CREATE TYPE "MassUnit" AS ENUM ('KG', 'TON');

-- CreateEnum
CREATE TYPE "MiscellaneousUnit" AS ENUM ('NUMBER', 'KM', 'TON_KM', 'PERSON_KM');

-- CreateEnum
CREATE TYPE "CurrencyUnit" AS ENUM ('DKK');

-- CreateEnum
CREATE TYPE "EmploymentUnit" AS ENUM ('EMPLOYEES_PER_YEAR');

-- CreateEnum
CREATE TYPE "Role" AS ENUM ('USER', 'ADMIN');

-- CreateEnum
CREATE TYPE "Category" AS ENUM ('ENVIRONMENTAL', 'SOCIAL', 'GOVERNANCE');

-- CreateTable
CREATE TABLE "User" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "role" "Role" NOT NULL DEFAULT 'USER',

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Report" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "title" TEXT NOT NULL,
    "authorId" INTEGER,

    CONSTRAINT "Report_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "KeyValue" (
    "id" SERIAL NOT NULL,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "reportId" INTEGER NOT NULL,
    "category" "Category" NOT NULL,

    CONSTRAINT "KeyValue_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmissionFactor" (
    "id" SERIAL NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "published" BOOLEAN NOT NULL DEFAULT false,
    "keyid" VARCHAR(255) NOT NULL,
    "version" VARCHAR(255) NOT NULL,
    "year" VARCHAR(255) NOT NULL,
    "energyUnit" "EnergyUnit",
    "volumeUnit" "VolumeUnit",
    "massUnit" "MassUnit",
    "miscellaneousUnit" "MiscellaneousUnit",
    "currencyUnit" "CurrencyUnit",
    "employmentUnit" "EmploymentUnit",
    "scope1fact" DECIMAL(10,2) NOT NULL,
    "scope2fact" DECIMAL(10,2) NOT NULL,
    "scope3fact" DECIMAL(10,2) NOT NULL,
    "outofscope" DECIMAL(10,2) NOT NULL,
    "value" DECIMAL(10,2) NOT NULL,

    CONSTRAINT "EmissionFactor_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- AddForeignKey
ALTER TABLE "Report" ADD CONSTRAINT "Report_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "KeyValue" ADD CONSTRAINT "KeyValue_reportId_fkey" FOREIGN KEY ("reportId") REFERENCES "Report"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
