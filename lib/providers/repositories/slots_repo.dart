import 'package:metadent_checkin_app/infra/models/models.dart';

import '../api/api.dart';

class SlotsRepo {
  final ApiClient apiClient;

  SlotsRepo({required this.apiClient});

  Future<ApiResponse<List<Slot>, Slot>> fetchAvailableFreeAppointmentSlots(
    int appointmentType,
    String firstName,
    String lastName,
    String dateOfBirth,
  ) async {
    return await apiClient.post(Urls.freeSlots, data: <String, dynamic>{
      "appointmentTypeId": appointmentType,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,//DateFormat('yyyy-MM-dd').format(DateTime.parse(dateOfBirth)),
    });
  }
}
