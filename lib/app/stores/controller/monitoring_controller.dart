import 'dart:async';

import 'package:mobx/mobx.dart';
part 'monitoring_controller.g.dart';

class MonitoringController = _MonitoringControllerBase
    with _$MonitoringController;

abstract class _MonitoringControllerBase with Store {
  @observable
  bool activeMonitoring = true;

//TODO: setar o valor desejado
  @observable
  int monitoringTotalHours = 0;

  @action
  setValue(bool value) {
    monitoringTotalHours = 0;
    activeMonitoring = value;
    if (value) {
      setTimer(activeMonitoring);
    }
  }

  int _start = 0;
  int _totalHours = 0;
  @action
  setTimer(bool isActive) {
    //TODO: setar o tempo desejado
    const oneHour = const Duration(seconds: 3600);
    Timer.periodic(
      oneHour,
      (Timer timer) {
        if (!isActive) {
          // _timer = null;
        } else {
          _start++;
          _totalHours = _start;
          monitoringTotalHours = _totalHours;
          // print(_totalHours);
        }
      },
    );
  }
}
