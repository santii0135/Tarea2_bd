/*
  Warnings:

  - You are about to drop the column `blockerId` on the `Bloquear` table. All the data in the column will be lost.
  - Added the required column `blockerEmail` to the `Bloquear` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "Bloquear" DROP CONSTRAINT "Bloquear_blockerId_fkey";

-- AlterTable
ALTER TABLE "Bloquear" DROP COLUMN "blockerId",
ADD COLUMN     "blockerEmail" INTEGER NOT NULL;

-- AddForeignKey
ALTER TABLE "Bloquear" ADD CONSTRAINT "Bloquear_blockerEmail_fkey" FOREIGN KEY ("blockerEmail") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
