const mongoose = require("mongoose");
const Schema = mongoose.Schema;

const AppointmentSchema = new Schema({
  client: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "User",
    required: true,
  },
  lawyer: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  date: { type: Date, required: true },
  timeSlot: { type: String, required: true }, // "10:00 AM - 11:00 AM"
  status: {
    type: String,
    enum: ["pending", "confirmed", "cancelled", "completed"],
    default: "pending",
  },
  meetingLink: { type: String }, // For video call
  notes: { type: String },
});

const Appointment = mongoose.model("Appointment", AppointmentSchema);

module.exports = Appointment;
