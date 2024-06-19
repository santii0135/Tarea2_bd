-- CreateTable
CREATE TABLE "DireccionBloqueada" (
    "id" SERIAL NOT NULL,
    "usuario_id" INTEGER NOT NULL,
    "direccion_bloqueada" TEXT NOT NULL,

    CONSTRAINT "DireccionBloqueada_pkey" PRIMARY KEY ("id")
);

-- AddForeignKey
ALTER TABLE "DireccionBloqueada" ADD CONSTRAINT "DireccionBloqueada_usuario_id_fkey" FOREIGN KEY ("usuario_id") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
