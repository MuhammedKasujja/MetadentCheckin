part of 'appointments_bloc.dart';

@immutable
class AppointmentsState extends Equatable {
  final String? error;
  final String? message;
  final AppState status;
  final List<Appointment>? data;
  final Appointment? activeAppointment;
  final List<AppointmentType>? appointmentTypes;
  final bool success;
  const AppointmentsState({
    this.error,
    this.message,
    required this.status,
    this.data,
    required this.success,
    this.appointmentTypes,
    this.activeAppointment,
  });

  AppointmentsState copyWith({
    String? error,
    String? message,
    required AppState status,
    List<Appointment>? data,
    List<AppointmentType>? appointmentTypes,
    bool? success,
    Appointment? activeAppointment,
  }) {
    return AppointmentsState(
      error: error,
      message: message,
      status: status,
      data: data ?? this.data,
      success: success ?? false,
      appointmentTypes: appointmentTypes ?? this.appointmentTypes,
      activeAppointment: activeAppointment ?? this.activeAppointment,
    );
  }

  @override
  List<Object?> get props => [
        error,
        message,
        status,
        data,
        success,
        appointmentTypes,
      ];
}
