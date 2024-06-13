import { Elysia } from "elysia";
import { PrismaClient } from '@prisma/client';

const prisma = new PrismaClient();
const app = new Elysia().decorate("db", prisma);

interface user {
  id: number;
  nombre: string;
  correo: string;
  clave: string;
  descripcion: string;
}

app.get("/api/usuarios", async ({ db }) => {
  return db.user.findMany();
});

app.get("/api/informacion/:correo", async ({ params, set }) => {
  const { correo } = params;

  try {
    const user = await prisma.user.findUnique({
      where: { correo: correo }
    });

    if (user) {
      set.status = 200;
      return {
        estado: 200,
        nombre: user.nombre,
        correo: user.correo,
        descripcion: user.descripcion
      };
    } else {
      set.status = 404;
      return {
        estado: 404,
        mensaje: "Usuario no encontrado"
      };
    }
  } catch (error) {
    set.status = 500;
    return {
      estado: 500,
      mensaje: "Error interno del servidor"
    };
  }
});


app.post("/api/registrar", async ({db, body}) => {
  try {
    // Attempt to create a user in the database
    const user = await db.user.create({
      data: body as user
    });

    // Return a success response if the user is created successfully
    return { status: 200, message: "Usuario creado correctamente", user };
  } catch (error) {
    // Handle specific errors like unique constraint violations (e.g., user already exists)
    if (error.code === 'P2002') {  
      return { status: 400, message: "Usuario ya existe" };
    }
    // Handle other generic errors
    return { status: 500, message: "Error interno del servidor", error: error.message };
  }
});


/*
// Endpoint para registrar un usuario
app.post("/api/registrarrr", async (req, res) => {
  // Extract data from the request body
  const { nombre, correo, clave, descripcion } = req.body;

  try {
    // Try to create a user in the database
    const user = await prisma.user.create({
      data: { nombre, correo, clave, descripcion },
    });

    // If user is created successfully, send a success response
    res.send({
      status: 200,
      message: "Se realizó la petición correctamente"
    });
  } catch (error) {
    // If there is an error, send an error response
    res.send({
      status: 400,
      message: "Ha existido un error al realizar la petición"
    });
  }
});
*/

// Iniciar el servidor en el puerto 3000
app.listen(3000, () => {
  console.log("Server running on http://localhost:3000");
});
