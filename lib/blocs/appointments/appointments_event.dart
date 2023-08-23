part of 'appointments_bloc.dart';

@immutable
abstract class AppointmentsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class Checkin extends AppointmentsEvent {
  final String dateOfBirth;

  Checkin({required this.dateOfBirth});
  @override
  List<Object?> get props => [dateOfBirth];
}

class FetchAppointmentsTypes extends AppointmentsEvent {}

class CreateAppointment extends AppointmentsEvent {
  final String firstName;
  final String dateOfBirth;
  final String lastName;
  final int appointmentType;
  final Slot slot;
  final int interval;

  CreateAppointment({
    required this.appointmentType,
    required this.slot,
    required this.interval,
    required this.dateOfBirth,
    required this.lastName,
    required this.firstName,
  });

  @override
  List<Object?> get props => [
        dateOfBirth,
        lastName,
        firstName,
      ];
}

class ResetAppointments extends AppointmentsEvent {}
