import fastify from "fastify";
import pg from "pg";
import dotenv from "dotenv";

dotenv.config();

const { Client } = pg;
const app = fastify();
const client = new Client({
  connectionString: process.env.DATABASE_URL,
});

const prefix = "/courses_final";

app.get("/", async (request, reply) => {
  return reply.redirect(`${prefix}/`);
});

app.get(`${prefix}/`, async (request, reply) => {
  try {
    const res = await client.query("SELECT * FROM courses");
    return res.rows;
  } catch (err) {
    app.log.error("Database query error:", err);
    return reply.status(500).send("Database query error");
  }
});

app.get(`${prefix}/teachers`, async (request, reply) => {
  try {
    const res = await client.query("SELECT * FROM teachers");
    return res.rows;
  } catch (err) {
    app.log.error("Database query error:", err);
    return reply.status(500).send("Database query error");
  }
});

app.get(`${prefix}/students`, async (request, reply) => {
  try {
    const res = await client.query("SELECT * FROM students");
    return res.rows;
  } catch (err) {
    app.log.error("Database query error:", err);
    return reply.status(500).send("Database query error");
  }
});

app.get(`${prefix}/registrations`, async (request, reply) => {
  try {
    const res = await client.query("SELECT * FROM registrations");
    return res.rows;
  } catch (err) {
    app.log.error("Database query error:", err);
    return reply.status(500).send("Database query error");
  }
});

app.get(`${prefix}/grades`, async (request, reply) => {
  try {
    const res = await client.query("SELECT * FROM grades");
    return res.rows;
  } catch (err) {
    app.log.error("Database query error:", err);
    return reply.status(500).send("Database query error");
  }
});

const start = async () => {
  try {
    const port = process.env.PORT || 3000;
    const host = "0.0.0.0";
    await app.listen({ port: Number(port), host });
    console.log(`Server is listening on http://localhost:${port}`);
  } catch (err) {
    console.error("Error starting server:", err);
    process.exit(1);
  }
};

client
  .connect()
  .then(() => {
    app.log.info("Connected to the database");
    start();
  })
  .catch((err) => {
    app.log.error("Database connection error", err);
  });
