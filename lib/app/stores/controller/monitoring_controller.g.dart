// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'monitoring_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$MonitoringController on _MonitoringControllerBase, Store {
  late final _$activeMonitoringAtom = Atom(
      name: '_MonitoringControllerBase.activeMonitoring', context: context);

  @override
  bool get activeMonitoring {
    _$activeMonitoringAtom.reportRead();
    return super.activeMonitoring;
  }

  @override
  set activeMonitoring(bool value) {
    _$activeMonitoringAtom.reportWrite(value, super.activeMonitoring, () {
      super.activeMonitoring = value;
    });
  }

  late final _$monitoringTotalHoursAtom = Atom(
      name: '_MonitoringControllerBase.monitoringTotalHours', context: context);

  @override
  int get monitoringTotalHours {
    _$monitoringTotalHoursAtom.reportRead();
    return super.monitoringTotalHours;
  }

  @override
  set monitoringTotalHours(int value) {
    _$monitoringTotalHoursAtom.reportWrite(value, super.monitoringTotalHours,
        () {
      super.monitoringTotalHours = value;
    });
  }

  late final _$_MonitoringControllerBaseActionController =
      ActionController(name: '_MonitoringControllerBase', context: context);

  @override
  dynamic setValue(bool value) {
    final _$actionInfo = _$_MonitoringControllerBaseActionController
        .startAction(name: '_MonitoringControllerBase.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$_MonitoringControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setTimer(bool isActive) {
    final _$actionInfo = _$_MonitoringControllerBaseActionController
        .startAction(name: '_MonitoringControllerBase.setTimer');
    try {
      return super.setTimer(isActive);
    } finally {
      _$_MonitoringControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
activeMonitoring: ${activeMonitoring},
monitoringTotalHours: ${monitoringTotalHours}
    ''';
  }
}
