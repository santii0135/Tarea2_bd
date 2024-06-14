-- CreateTable
CREATE TABLE "Favorito" (
    "id" SERIAL NOT NULL,
    "correo" TEXT NOT NULL,
    "id_favorito" INTEGER NOT NULL,

    CONSTRAINT "Favorito_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "Favorito" ADD CONSTRAINT "Favorito_correo_fkey" FOREIGN KEY ("correo") REFERENCES "User"("correo") ON DELETE RESTRICT ON UPDATE CASCADE;
