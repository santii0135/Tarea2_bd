import { Elysia } from "elysia";
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const app = new Elysia().decorate("db", prisma);

app.post("/api/registrar", async ({db, body}) => {
  try {
    // Attempt to create a user in the database
    const user = await db.user.create({
      data: body as { nombre: string, correo: string, clave: string },
    });

    // Return a success response if the user is created successfully
    return { estado: 200, message: "Usuario creado correctamente", user };
  } catch (error) {
    // Handle specific errors like unique constraint violations (e.g., user already exists)
    if (error.code === 'P2002') {  
      return { estado: 400, message: "Usuario ya existe" };
    }
    // Handle other generic errors
    return { estado: 500, message: "Error interno del servidor", error: error.message };
  }
});

//Mostrar todos los usuarios mmarcaos como favoritos por un usuario
app.get("/api/favoritos/:correo", async ({ db, params }) => {
  const favoritos = await db.favorito.findMany({
    where: { correo: String(params.correo) },
    select: { id_correo_favorito: true }
  });
  if (favoritos.length === 0) {
    return { estado: 404, message: "No se encontraron favoritos para este usuario" };
  }
  return { estado: 200, favoritos };
});


// Mostrar información de un usuario
app.get("/api/informacion/:correo", async ({ db, params }) => {
  const user = await db.user.findUnique({
    where: { correo: String(params.correo) },
    select: {
      id: true,
      nombre: true,
      correo: true,
      descripcion: true,
      // Excluir la clave
    }
  });

  if (!user) {
    return { estado: 404, message: "Usuario no encontrado" };
  }

  return user;
});


// Bloquear a un usuario
app.post("/api/bloquear", async ({ db, body }) => {
  const { correo , clave, correo_bloquear} = body as { correo: string, clave: string, correo_bloquear: string };
  if (correo === correo_bloquear) {
    return { estado: 400, message: "No puedes bloquearte a ti mismo" };
  }
    // Verificar credenciales
  const user = await db.user.findUnique({
    where: { correo: correo },
  });

  if (!user) {
    return { estado: 404, mensaje: "Usuario no encontrado" };
  }

  if (!user || user.clave !== clave) {
    return { estado: 400, message: "Credenciales incorrectas" };
  }
  // Verificar si ya existe un bloqueo
  const existeBloqueo = await db.bloquear.findFirst({
    where: {
      correo: correo,
      correo_bloquear: correo_bloquear
    }
  });
  if (existeBloqueo) {
    return { estado: 400, mensaje: "El usuario ya ha sido bloqueado previamente" };
  }
  // Bloquear al usuario
  // Verificar si el usuario a bloquear existe
  const usuarioABloquear = await db.user.findUnique({
    where: { correo: correo_bloquear },
  });

  if (!usuarioABloquear) {
    return { estado: 404, mensaje: "Usuario a bloquear no encontrado" };
  }
  const bloquear = await db.bloquear.create({
    data: { correo, correo_bloquear },
  });
  return { estado: 200, mensaje: "Usuario bloqueado correctamente" };
});


// Marcar a un usuario como favorito
app.post("/api/marcarcorreo", async ({ db, body }) => {
  const { correo , clave, id_correo_favorito} = body as { correo: string, clave: string, id_correo_favorito: number};
    // Verificar credenciales
  const user = await db.user.findUnique({
    where: { correo: correo },
  });

  if (!user) {
    return { estado: 404, mensaje: "Usuario no encontrado" };
  }

  if (!user || user.clave !== clave) {
    return { estado: 400, message: "Credenciales incorrectas" };
  }
  // Verificar si ya esta marcado como favorito
  const existeFavorito = await db.favorito.findFirst({
    where: {
      correo: correo,
      id_correo_favorito: id_correo_favorito
    }
  });
  if (existeFavorito) {
    return { estado: 400, mensaje: "El usuario ya ha sido marcado como favorito" };
  }
  // Marcar al usuario
  // Verificar si el usuario a ser favorito existe
  const usuarioFavorito = await db.user.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!usuarioFavorito) {
    return { estado: 404, mensaje: "Usuario a marcar no encontrado" };
  }
  await db.favorito.create({
    data: { correo, id_correo_favorito},
  });
  return { estado: 200, mensaje: "Usuario marcado correctamente" };
});


// Desmarcar a un usuario de favorito
app.delete("/api/desmarcarcorreo", async ({ db, body }) => {
  const { correo , clave, id_correo_favorito} = body as { correo: string, clave: string, id_correo_favorito: number};
    // Verificar credenciales
  const user = await db.user.findUnique({
    where: { correo: correo },
  });

  if (!user) {
    return { estado: 404, mensaje: "Usuario no encontrado" };
  }

  if (!user || user.clave !== clave) {
    return { estado: 400, message: "Credenciales incorrectas" };
  }
  // Verificar si esta marcado como favorito
  const existeFavorito = await db.favorito.findFirst({
    where: {
      correo: correo,
      id_correo_favorito: id_correo_favorito
    }
  });
  if (!existeFavorito) {
    return { estado: 400, mensaje: "El usuario no ha sido marcado como favorito" };
  }
  // Verificar si el usuario a desmarcar existe
  const usuarioFavorito = await db.user.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!usuarioFavorito) {
    return { estado: 404, mensaje: "Usuario a desmarcar no encontrado" };
  }
  await db.favorito.delete({
    where: {
      id: existeFavorito.id
    }
  });
  return { estado: 200, mensaje: "Usuario desmarcado correctamente" };
});

app.get("/api/login/:correo", async ({ db, params }) => {
  const user = await db.user.findUnique({ where: { correo: String(params.correo) } });
  if (!user) {
    return { estado: 404, message: "Usuario no encontrado" };
  }
  return user;
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
