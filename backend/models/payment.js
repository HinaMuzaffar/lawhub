const mongoose = require("mongoose");
const Schema = mongoose.Schema;
const PaymentSchema = new Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  appointment: { type: mongoose.Schema.Types.ObjectId, ref: "Appointment" },
  amount: { type: Number, required: true },
  currency: { type: String, default: "USD" },
  status: {
    type: String,
    enum: ["pending", "paid", "failed"],
    default: "pending",
  },
  transactionId: { type: String },
  createdAt: { type: Date, default: Date.now },
});

const Payment = mongoose.model("Payment", PaymentSchema);

module.exports = Payment;
