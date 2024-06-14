/*
  Warnings:

  - You are about to drop the `DireccionBloqueada` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "DireccionBloqueada" DROP CONSTRAINT "DireccionBloqueada_usuario_id_fkey";

-- DropTable
DROP TABLE "DireccionBloqueada";

-- CreateTable
CREATE TABLE "Bloquear" (
    "id" SERIAL NOT NULL,
    "blockerId" INTEGER NOT NULL,
    "blockedEmail" TEXT NOT NULL,

    CONSTRAINT "Bloquear_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Bloquear" ADD CONSTRAINT "Bloquear_blockerId_fkey" FOREIGN KEY ("blockerId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
