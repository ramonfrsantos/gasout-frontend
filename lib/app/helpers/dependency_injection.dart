import 'package:gas_out_app/app/stores/controller/monitoring_controller.dart';
import 'package:gas_out_app/app/stores/controller/room/room_controller.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton<MonitoringController>(
      () => MonitoringController());
  getIt.registerLazySingleton<RoomController>(
          () => RoomController());
}
