/*
  Warnings:

  - You are about to drop the column `id_correo_favorito` on the `favorito` table. All the data in the column will be lost.
  - Added the required column `correo_favorito` to the `favorito` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE "favorito" DROP COLUMN "id_correo_favorito",
ADD COLUMN     "correo_favorito" TEXT NOT NULL;
