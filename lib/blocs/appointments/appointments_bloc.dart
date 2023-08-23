import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:metadent_checkin_app/infra/models/models.dart';
import 'package:metadent_checkin_app/providers/providers.dart';

part 'appointments_event.dart';
part 'appointments_state.dart';

class AppointmentsBloc extends Bloc<AppointmentsEvent, AppointmentsState> {
  final AppointmentsRepo appointmentsRepo;

  AppointmentsBloc({required this.appointmentsRepo})
      : super(
          const AppointmentsState(
            status: AppState.init,
            success: false,
          ),
        ) {
    on<CreateAppointment>((event, emit) async {
      emit(state.copyWith(status: AppState.loading));
      final res = await appointmentsRepo.save(
        event.appointmentType,
        event.firstName,
        event.lastName,
        event.dateOfBirth,
        event.slot,
        event.interval,
      );
      emit(
        state.copyWith(
          success: res.success,
          status: res.status,
          message: res.message,
          error: res.error,
        ),
      );
      // if (res.success) {
      //   add(FetchAppointments());
      // }
    });

    on<FetchAppointmentsTypes>((event, emit) async {
      emit(state.copyWith(status: AppState.loading));
      final res = await appointmentsRepo.fetchTypes();
      emit(
        state.copyWith(
          appointmentTypes: res.data,
          success: res.success,
          status: res.status,
          message: res.message,
          error: res.error,
        ),
      );
    });

    on<Checkin>((event, emit) async {
      emit(state.copyWith(status: AppState.loading));
      final res = await appointmentsRepo.checkin(event.dateOfBirth);
      emit(
        state.copyWith(
          status: res.status,
          success: res.success,
          message: res.message,
          error: res.error,
        ),
      );
    });

    on<ResetAppointments>((event, emit) {
      emit(
        const AppointmentsState(
          status: AppState.init,
          success: false,
        ),
      );
    });
  }
}
