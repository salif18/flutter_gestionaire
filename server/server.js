//creation du server
const http = require("http");
const app = require("./app");
const dotenv = require("dotenv");

//config
dotenv.config();
app.set(process.env.PORT || 3001);

const server = http.createServer(app);

server.listen(process.env.PORT, () =>
  console.log(`server en marche sur le PORT:${process.env.PORT}`)
);
