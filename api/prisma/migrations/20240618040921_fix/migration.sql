/*
  Warnings:

  - You are about to drop the `Bloquear` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Favorito` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `User` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Bloquear" DROP CONSTRAINT "Bloquear_correo_fkey";

-- DropForeignKey
ALTER TABLE "Favorito" DROP CONSTRAINT "Favorito_correo_fkey";

-- DropTable
DROP TABLE "Bloquear";

-- DropTable
DROP TABLE "Favorito";

-- DropTable
DROP TABLE "User";

-- CreateTable
CREATE TABLE "user" (
    "id" SERIAL NOT NULL,
    "nombre" TEXT NOT NULL,
    "correo" TEXT NOT NULL,
    "clave" TEXT NOT NULL,
    "descripcion" TEXT,

    CONSTRAINT "user_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "bloquear" (
    "id" SERIAL NOT NULL,
    "correo" TEXT NOT NULL,
    "correo_bloquear" TEXT NOT NULL,

    CONSTRAINT "bloquear_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "favorito" (
    "id" SERIAL NOT NULL,
    "correo" TEXT NOT NULL,
    "id_correo_favorito" INTEGER NOT NULL,

    CONSTRAINT "favorito_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "user_correo_key" ON "user"("correo");

-- AddForeignKey
ALTER TABLE "bloquear" ADD CONSTRAINT "bloquear_correo_fkey" FOREIGN KEY ("correo") REFERENCES "user"("correo") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "favorito" ADD CONSTRAINT "favorito_correo_fkey" FOREIGN KEY ("correo") REFERENCES "user"("correo") ON DELETE RESTRICT ON UPDATE CASCADE;
