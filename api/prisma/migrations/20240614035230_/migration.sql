/*
  Warnings:

  - You are about to drop the column `blockedEmail` on the `Bloquear` table. All the data in the column will be lost.
  - You are about to drop the column `blockerEmail` on the `Bloquear` table. All the data in the column will be lost.
  - Added the required column `clave` to the `Bloquear` table without a default value. This is not possible if the table is not empty.
  - Added the required column `correo` to the `Bloquear` table without a default value. This is not possible if the table is not empty.
  - Added the required column `correo_bloquear` to the `Bloquear` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Bloquear" DROP CONSTRAINT "Bloquear_blockerEmail_fkey";

-- AlterTable
ALTER TABLE "Bloquear" DROP COLUMN "blockedEmail",
DROP COLUMN "blockerEmail",
ADD COLUMN     "clave" TEXT NOT NULL,
ADD COLUMN     "correo" TEXT NOT NULL,
ADD COLUMN     "correo_bloquear" TEXT NOT NULL;

-- AddForeignKey
ALTER TABLE "Bloquear" ADD CONSTRAINT "Bloquear_correo_fkey" FOREIGN KEY ("correo") REFERENCES "User"("correo") ON DELETE RESTRICT ON UPDATE CASCADE;
