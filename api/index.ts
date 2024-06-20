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

    console.log(`[${new Date().toLocaleTimeString()}] Se ha registrado el usuario: ${body.nombre} de forma correcta`);
    // Retorna el usuario creado
    return { estado: 200, message: "Usuario creado correctamente", user };
  } catch (error) {
    // Verifica si ya existe un usuario con el mismo correo
    if (error.code === 'P2002') {  
      console.log(`[${new Date().toLocaleTimeString()}] Error de registro: el usuario con correo ${body.correo} ya existe`);
      return { estado: 400, message: "Usuario ya existe" };
    }
    // Algun otro error
    return { estado: 500, message: "Error interno del servidor", error: error.message };
  }
});


// Mostrar información de un usuario
app.get("/api/informacion/:correo", async ({ db, params }) => {
  console.log(`[${new Date().toLocaleTimeString()}] Consulta de información para el usuario: ${params.correo}`);
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
  console.log(`[${new Date().toLocaleTimeString()}] Intento de bloqueo por el usuario: ${body.correo} para bloquear a: ${body.correo_bloquear}`);
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


// Marcar a un correo como favorito
app.post("/api/marcarcorreo", async ({ db, body }) => {
  console.log(`[${new Date().toLocaleTimeString()}] Marcar como favorito: intento de ${body.correo} para marcar correo con ID ${body.id_correo_favorito}`);
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
    return { estado: 400, mensaje: "El correo ya ha sido marcado como favorito" };
  }
  // Marcar al usuario
  // Verificar si el usuario a ser favorito existe
  const correoFavorito = await db.correo.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!correoFavorito) {
    return { estado: 404, mensaje: "Correo a marcar no encontrado" };
  }
  await db.favorito.create({
    data: { correo, id_correo_favorito},
  });
  return { estado: 200, mensaje: "Correo marcado correctamente" };
});


// Desmarcar a un usuario de favorito
app.delete("/api/desmarcarcorreo", async ({ db, body }) => {
  console.log(`[${new Date().toLocaleTimeString()}] Intento de desmarcar el correo con ID ${body.id_correo_favorito} como favorito por el usuario: ${body.correo}`);
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
    return { estado: 400, mensaje: "El Correo no ha sido marcado como favorito" };
  }
  // Verificar si el usuario a desmarcar existe
  const correoFavorito = await db.correo.findUnique({
    where: { id: id_correo_favorito },
  });

  if (!correoFavorito) {
    return { estado: 404, mensaje: "Correo a desmarcar no encontrado" };
  }
  await db.favorito.delete({
    where: {
      id: existeFavorito.id
    }
  });
  return { estado: 200, mensaje: "Correo desmarcado correctamente" };
});

app.get("/api/login/:correo", async ({ db, params }) => {
  const user = await db.user.findUnique({ where: { correo: String(params.correo) } });
  if (!user) {
    console.log(`[${new Date().toLocaleTimeString()}] Usuario no encontrado: ${params.correo}`);
    return { estado: 404, message: "Usuario no encontrado" };
  }
  return user;
});

//Mostrar todos los usuarios mmarcados como favoritos por un usuario
app.get("/api/favoritos/:correo", async ({ db, params }) => {
  console.log(`[${new Date().toLocaleTimeString()}] Mostrar correos marcados como favoritos por el usuario: ${params.correo}`);
  const favoritos = await db.favorito.findMany({
    where: { correo: String(params.correo) },
    select: { id_correo_favorito: true }
  });
  if (favoritos.length === 0) {
    return { estado: 404, message: "No se encontraron favoritos para este usuario" };
  }
  return { estado: 200, favoritos };
});

app.get("/api/info_correo/:id", async ({ db, params }) => {
  console.log(`[${new Date().toLocaleTimeString()}] Mostrar información del correo con ID: ${params.id}`);
  const correo = await db.correo.findUnique({
    where: { id: Number(params.id) }
  });
  if (!correo) {
    return { estado: 404, message: "Correo no encontrado" };
  }
  return correo;
});

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
