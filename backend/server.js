const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();

const app = express();
app.use(cors());
app.use(express.json());

async function main() {
  await mongoose.connect("mongodb://127.0.0.1:27017/lawhub");
}
main()
  .then(() => {
    console.log("connected to DB");
  })
  .catch((err) => {
    console.log(err);
  });

app.get("/", (req, res) => {
  res.send("Hi! I am root.");
});
let port = 8080;

app.listen(port, () => {
  console.log(`app is listening to ${port}`);
});
