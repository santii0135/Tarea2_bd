import { Elysia } from "elysia";
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const app = new Elysia().decorate("db", prisma);

app.post("/api/registrar", async ({db, body}) => {
  try {
    // Attempt to create a user in the database
    const user = await db.user.create({
      data: body as user
    });

    // Return a success response if the user is created successfully
    return { estado: 200, message: "Usuario creado correctamente", user };
  } catch (error:unknown) {
    // Handle specific errors like unique constraint violations (e.g., user already exists)
    if (error.code === 'P2002') {  
      return { estado: 400, message: "Usuario ya existe" };
    }
    // Handle other generic errors
    return { estado: 500, message: "Error interno del servidor", error: error.message };
  }
});


// Definir el modelo de usuario
app.get("/api/usuarios", async ({ db }) => {
  return db.user.findMany();
});


app.get("/api/informacion/:correo", async ({ db, params }) => {
  try {
    return db.user.findUnique({where: {correo: String(params.correo)}});
  } catch (error) {
    return { estado: 404, message: "Usuario no encontrado" };
  }
});

app.post("/api/bloquear", async ({ db, body }) => {
  const { correo , clave, correo_bloquear} = body;
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
  const existeBloqueo = await db.Bloquear.findFirst({
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
  const bloquear = await db.Bloquear.create({
    data: { correo, correo_bloquear },
  });
  return { estado: 200, mensaje: "Usuario bloqueado correctamente" };
});



app.post("/api/marcarcorreo", async ({ db, body }) => {
  const { correo , clave, id_correo_favorito} = body;
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
  const existeFavorito = await db.Favorito.findFirst({
    where: {
      correo: correo,
      id_correo_favorito: id_correo_favorito
    }
  });
  if (existeFavorito) {
    return { estado: 400, mensaje: "El usuario ya ha sido marcado como favorito" };
  }
  // Marcar al usuario
  // Verificar si el usuario a ser favorito
  const usuarioFavorito = await db.user.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!usuarioFavorito) {
    return { estado: 404, mensaje: "Usuario a marcar no encontrado" };
  }
  await db.Favorito.create({
    data: { correo, id_correo_favorito},
  });
  return { estado: 200, mensaje: "Usuario marcado correctamente" };
});


app.delete("/api/desmarcarcorreo", async ({ db, body }) => {
  const { correo , clave, id_correo_favorito} = body;
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
  const existeFavorito = await db.Favorito.findFirst({
    where: {
      correo: correo,
      id_correo_favorito: id_correo_favorito
    }
  });
  if (!existeFavorito) {
    return { estado: 400, mensaje: "El usuario no ha sido marcado como favorito" };
  }
  // Verificar si el usuario a ser favorito
  const usuarioFavorito = await db.user.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!usuarioFavorito) {
    return { estado: 404, mensaje: "Usuario a desmarcar no encontrado" };
  }
  await db.Favorito.delete({
    where: {
      id: existeFavorito.id
    }
  });
  return { estado: 200, mensaje: "Usuario desmarcado correctamente" };
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
