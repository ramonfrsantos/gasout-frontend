// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoomController on _RoomControllerBase, Store {
  late final _$sprinklersValueAtom =
      Atom(name: '_RoomControllerBase.sprinklersValue', context: context);

  @override
  bool get sprinklersValue {
    _$sprinklersValueAtom.reportRead();
    return super.sprinklersValue;
  }

  @override
  set sprinklersValue(bool value) {
    _$sprinklersValueAtom.reportWrite(value, super.sprinklersValue, () {
      super.sprinklersValue = value;
    });
  }

  late final _$roomListAtom =
      Atom(name: '_RoomControllerBase.roomList', context: context);

  @override
  List<DataRoom>? get roomList {
    _$roomListAtom.reportRead();
    return super.roomList;
  }

  @override
  set roomList(List<DataRoom>? value) {
    _$roomListAtom.reportWrite(value, super.roomList, () {
      super.roomList = value;
    });
  }

  late final _$getUserRoomsAsyncAction =
      AsyncAction('_RoomControllerBase.getUserRooms', context: context);

  @override
  Future getUserRooms(String? login) {
    return _$getUserRoomsAsyncAction.run(() => super.getUserRooms(login));
  }

  late final _$sendRoomSensorValueAsyncAction =
      AsyncAction('_RoomControllerBase.sendRoomSensorValue', context: context);

  @override
  Future sendRoomSensorValue(String name, String email, bool alarmOn,
      bool notificationOn, bool sprinklersOn, int sensorValue) {
    return _$sendRoomSensorValueAsyncAction.run(() => super.sendRoomSensorValue(
        name, email, alarmOn, notificationOn, sprinklersOn, sensorValue));
  }

  late final _$_RoomControllerBaseActionController =
      ActionController(name: '_RoomControllerBase', context: context);

  @override
  dynamic setSprinklersValue(bool value) {
    final _$actionInfo = _$_RoomControllerBaseActionController.startAction(
        name: '_RoomControllerBase.setSprinklersValue');
    try {
      return super.setSprinklersValue(value);
    } finally {
      _$_RoomControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
sprinklersValue: ${sprinklersValue},
roomList: ${roomList}
    ''';
  }
}
