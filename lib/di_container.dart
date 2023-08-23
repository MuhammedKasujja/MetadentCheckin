import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:metadent_checkin_app/providers/providers.dart';

import 'blocs/blocs.dart';

final sl = GetIt.I;

Future init() async {
  // Core
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  // Repository
  sl.registerLazySingleton(() => AppointmentsRepo(apiClient: sl()));
  sl.registerLazySingleton(() => SlotsRepo(apiClient: sl()));

  // Blocs
  sl.registerFactory(() => AppointmentsBloc(appointmentsRepo: sl()));
  sl.registerFactory(() => SlotsBloc(slotsRepo: sl()));

  // External
  sl.registerLazySingleton(() => Dio());
}

List<BlocProvider> get blocs => [
      BlocProvider<AppointmentsBloc>(
        create: (context) => sl<AppointmentsBloc>(),
      ),
      BlocProvider<SlotsBloc>(
        create: (context) => sl<SlotsBloc>(),
      ),
    ];

Future resetBlocs() async {
  sl<AppointmentsBloc>().add(ResetAppointments());
}