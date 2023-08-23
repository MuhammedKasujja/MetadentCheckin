import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metadent_checkin_app/infra/infra.dart';
import 'package:metadent_checkin_app/providers/providers.dart';

part 'slots_event.dart';
part 'slots_state.dart';

class SlotsBloc extends Bloc<SlotsEvent, SlotsState> {
  final SlotsRepo slotsRepo;
  SlotsBloc({required this.slotsRepo})
      : super(
          const SlotsState(
            status: AppState.init,
            success: false,
          ),
        ) {
    on<FetchFreeAppointmentSlots>((event, emit) async {
      emit(state.copyWith(status: AppState.loading));
      final res = await slotsRepo.fetchAvailableFreeAppointmentSlots(
        event.appointmentType,
        event.firstName,
        event.lastName,
        event.dateOfBirth,
      );
      emit(
        state.copyWith(
          data: res.data,
          success: res.success,
          status: res.status,
          message: res.message,
          error: res.error,
        ),
      );
      if (res.success) add(const OrderSlots(AppoinmentTimeType.morning));
    });
    on<OrderSlots>((event, emit) {
      final filteredSlots = List<Slot>.from(state.data!);

      filteredSlots.where((ele) {
        var hour = DateTime.parse("2022-01-01 ${ele.startTime}").hour;
        if (event.type == AppoinmentTimeType.morning) {
          return hour < 12;
        }
        if (event.type == AppoinmentTimeType.afternoon) {
          return hour < 17;
        }
        return hour >= 17;
      }).toList();

      emit(
        state.copyWith(
          filteredSlots: filteredSlots,
          data: state.data,
          success: true,
          status: AppState.loaded,
        ),
      );
    });

    on<ClearSlots>((event, emit) {
      emit(
        const SlotsState(
          status: AppState.init,
          success: false,
        ),
      );
    });
  }
}
