part of 'slots_bloc.dart';

abstract class SlotsEvent extends Equatable {
  const SlotsEvent();

  @override
  List<Object> get props => [];
}

class FetchFreeAppointmentSlots extends SlotsEvent {
  final int appointmentType;
  final String firstName;
  final String lastName;
  final String dateOfBirth;

  const FetchFreeAppointmentSlots({
    required this.appointmentType,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
  });

  @override
  List<Object> get props => [
        appointmentType,
        firstName,
        lastName,
        dateOfBirth,
      ];
}

class OrderSlots extends SlotsEvent {
  final AppoinmentTimeType type;

  const OrderSlots(this.type);
  @override
  List<Object> get props => [type];
}

class ClearSlots extends SlotsEvent {}
