class Urls {
  Urls._();

  static const String baseUrl = "https://dev.api.metadent.nl/api/patients";

  // static const String baseUrl = "http://10.0.2.2:8000/api/patients";

  // static const String baseUrl = "http://127.0.0.1:8000/api/patients";

  static const appointments = "/checkin_app/waiting_room";
  static const appointmentsTypes = "/checkin_app/appointment_types";
  static const createAppointment = "/checkin_app/create_appointment";
  static const invoices = "/invoices/all";
  static const checkin = "/checkin_app/self_checkin";

  static const freeSlots = "/checkin_app/get_checkin_patient_slots";
}
