import 'package:metadent_checkin_app/infra/models/models.dart';

class Generic {
  static T fromJson<T, K>(dynamic json) {
    if (json is Iterable) {
      return _fromJsonList<K>(json) as T;
    } else if (T == Appointment) {
      return Appointment.fromJson(json) as T;
    } else if (T == AppointmentType) {
      return AppointmentType.fromJson(json) as T;
    } else if (T == Treatment) {
      return Treatment.fromJson(json) as T;
    } else if (T == bool || T == String || T == int || T == double) {
      // primitives
      return json;
    } else if (T == Slot) {
      return Slot.fromJson(json) as T;
    } else {
      throw Exception("Unknown class [$T]");
    }
  }

  ///
  /// for Lists, for each subtype [K], create its corresponding [fromJson] value
  ///
  static List<K> _fromJsonList<K>(Iterable jsonList) {
    return jsonList.map<K>((dynamic json) => fromJson<K, void>(json)).toList();
  }
}

class ApiResponse<T, K> {
  bool success;
  T? data;
  String? message;
  String? error;
  AppState status;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
    required this.status,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) =>
      _$WrapperFromJson(json);

  Map<String, dynamic> toJson() => _$WrapperToJson(this);
}

ApiResponse<T, K> _$WrapperFromJson<T, K>(Map<String, dynamic> json) {
  return ApiResponse<T, K>(
    success: json['status'] == 'SUCCESS' || json['status'],
    status: (json['status'] == 'SUCCESS' || json['status'])
        ? AppState.loaded
        : AppState.failure,
    data: json['payload'] == null
        ? null
        : T == dynamic // for converting data when <T> is not defined
            ? json['payload']
            : Generic.fromJson<T, K>(json['payload']),
    message: json['payload'] is String ? json['payload'] : json['message'],
    error: json['error'] is List
        ? (json['error'] as List)
            .reduce((value, element) => value + ", " + element)
        : json['error'],
  );
}

Map<String, dynamic> _$WrapperToJson(ApiResponse wrapper) => {
      "status": wrapper.success,
      "payload": wrapper.data,
      "message": wrapper.message,
      "error": wrapper.error,
    };
