import 'package:metadent_checkin_app/infra/infra.dart';
import 'package:metadent_checkin_app/providers/api/api.dart';

class AppointmentsRepo {
  final ApiClient apiClient;

  AppointmentsRepo({required this.apiClient});

  Future<ApiResponse<List<AppointmentType>, AppointmentType>>
      fetchTypes() async {
    return await apiClient.post(Urls.appointmentsTypes);
  }

  Future<ApiResponse> save(
    int appointmentType,
    String firstName,
    String lastName,
    String dateOfBirth,
    Slot slot,
    int interval,
  ) async {
    return await apiClient.post(Urls.createAppointment, data: <String, dynamic>{
      "appointmentTypeId": appointmentType,
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dateOfBirth,
      "sourceId": 3,
      "periodId": 3,
      "interval": interval,
      "comments": "",
      "slots": slot.toJson()
    });
  }

  Future<ApiResponse> checkin(String dateOfBirth) async {
    var splitDate = dateOfBirth.split('-');
    final formatedDate = '${splitDate[2]}-${splitDate[1]}-${splitDate[0]}';
    return await apiClient.post(Urls.checkin, data: <String, dynamic>{
      'date_of_birth': formatedDate,
    });
  }
}
