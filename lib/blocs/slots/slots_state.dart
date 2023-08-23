part of 'slots_bloc.dart';

@immutable
class SlotsState extends Equatable {
  final String? error;
  final String? message;
  final AppState status;
  final List<Slot>? data;
  final List<Slot>? filteredSlots;
  final bool success;
  const SlotsState({
    this.error,
    this.message,
    required this.status,
    this.data,
    required this.success,
    this.filteredSlots,
  });

  SlotsState copyWith({
    String? error,
    String? message,
    required AppState status,
    List<Slot>? data,
    bool? success,
    List<Slot>? filteredSlots,
  }) {
    return SlotsState(
      error: error,
      message: message,
      status: status,
      data: data,
      success: success ?? false,
      filteredSlots: filteredSlots,
    );
  }

  @override
  List<Object?> get props => [
        error,
        message,
        status,
        success,
      ];
}
