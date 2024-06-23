/*
  Warnings:

  - Added the required column `cuerpo` to the `correo` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "correo" ADD COLUMN     "cuerpo" TEXT NOT NULL;
