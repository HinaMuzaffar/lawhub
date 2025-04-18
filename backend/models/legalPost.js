const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const LegalPostSchema = new Schema({
  author: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  title: { type: String, required: true },
  content: { type: String, required: true },
  tags: [String],
  createdAt: { type: Date, default: Date.now },
  likes: [{ type: mongoose.Schema.Types.ObjectId, ref: "User" }],
  comments: [
    {
      commenter: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
      text: String,
      createdAt: { type: Date, default: Date.now },
    },
  ],
});

const LegalPost = mongoose.model("LegalPost", LegalPostSchema);

module.exports = LegalPost;
