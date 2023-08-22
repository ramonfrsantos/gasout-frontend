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

  @action
  setValue(bool value) {
    monitoringTotalHours = 0;
    activeMonitoring = value;
    setTimer(activeMonitoring);
  }

  @observable
  int _start = 0;

  @observable
  int _totalHours = 0;

  @action
  setTimer(bool isActive) {
    //TODO: setar o tempo desejadoG
    const oneHour = const Duration(seconds: 3);
    Timer.periodic(
      oneHour,
      (Timer timer) {
        if (isActive) {
          _start++;
        } else {
          _start = 0;
        }

        _totalHours = _start;
        monitoringTotalHours = _totalHours;
      },
    );
  }
}
