const express = require("express");
const mongoose = require("mongoose");
const cors = require("cors");
require("dotenv").config();
const app = express();
app.use(cors());
app.use(express.json());
mongoose.connect("mongodb://localhost:27017/lawhub", {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});then(() => console.log('MongoDB Connected'));

const UserSchema = new mongoose.Schema({
    name: String,
    email: String,
    phone: String,
});

const User = mongoose.model('User', UserSchema);

// CREATE
app.post('/users', async (req, res) => {
    const user = new User(req.body);
    await user.save();
    res.send(user);
});

// READ
app.get('/users', async (req, res) => {
    const users = await User.find();
    res.send(users);
});

// UPDATE
app.put('/users/:id', async (req, res) => {
    const updatedUser = await User.findByIdAndUpdate(req.params.id, req.body, { new: true });
    res.send(updatedUser);
});

// DELETE
app.delete('/users/:id', async (req, res) => {
    await User.findByIdAndDelete(req.params.id);
    res.send({ message: 'User deleted' });
});


app.listen(5000, () => {
  console.log("Server running on port 5000");
});
const admin = require('firebase-admin');
const serviceAccount = require('./firebaseServiceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

async function main() {
  mongoose.connect('mongodb://localhost:27017/lawhub');

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
