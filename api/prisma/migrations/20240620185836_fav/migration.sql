-- CreateTable
CREATE TABLE "correo" (
    "id" SERIAL NOT NULL,
    "remitente_id" INTEGER NOT NULL,
    "destinatario_id" INTEGER NOT NULL,
    "asunto" TEXT NOT NULL,

    CONSTRAINT "correo_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "favorito" ADD CONSTRAINT "favorito_id_correo_favorito_fkey" FOREIGN KEY ("id_correo_favorito") REFERENCES "correo"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
