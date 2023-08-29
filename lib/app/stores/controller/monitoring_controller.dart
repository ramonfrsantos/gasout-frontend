import 'dart:async';

import 'package:mobx/mobx.dart';

part 'monitoring_controller.g.dart';

class MonitoringController = _MonitoringControllerBase
    with _$MonitoringController;

abstract class _MonitoringControllerBase with Store {
  @observable
  bool activeMonitoring = false;

//TODO: setar o valor desejado
  @observable
  int monitoringTotalHours = 0;

}
