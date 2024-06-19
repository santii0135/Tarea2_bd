-- DropForeignKey
ALTER TABLE "Bloquear" DROP CONSTRAINT "Bloquear_blockerEmail_fkey";

-- AlterTable
ALTER TABLE "Bloquear" ALTER COLUMN "blockerEmail" SET DATA TYPE TEXT;

-- AddForeignKey
ALTER TABLE "Bloquear" ADD CONSTRAINT "Bloquear_blockerEmail_fkey" FOREIGN KEY ("blockerEmail") REFERENCES "User"("correo") ON DELETE RESTRICT ON UPDATE CASCADE;
