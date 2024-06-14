/*
  Warnings:

  - You are about to drop the column `id_favorito` on the `Favorito` table. All the data in the column will be lost.
  - Added the required column `id_correo_favorito` to the `Favorito` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "Favorito" DROP COLUMN "id_favorito",
ADD COLUMN     "id_correo_favorito" INTEGER NOT NULL;
