### Tarea 2: Base de Datos

**Pre-requisitos:**
- Asegúrese de tener instalada la última versión de Node.js

**Configuración inicial:**
1. Instale `bun` :
   curl -fsSL https://bun.sh/install | bash

**Configuración de la API:**
1. Navegue a la carpeta `api`:
   cd api

2. Agregue las dependencias necesarias con Bun:
   bun add @prisma/client prisma

3. Instale `elysia` utilizando npm:
   npm install elysia

4. Genere los archivos necesarios con Prisma `npx generate prisma`, o utilize la base de datos Communiken.sql:
   
5. Se debe editar el .env y colocar el nombre de la BD con su usuario y contraseña para conectarlo con PrismaJS

6. Instalar las dependencias usando `pip -r requirements.txt`
   
**Ejecución:**
1. Dentro de la carpeta `/api`, ejecute:
   bun run index.ts

2. En la carpeta `/client`, ejecute:
   python client.py

Seguir las instrucciones del menú

