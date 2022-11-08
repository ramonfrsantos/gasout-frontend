// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$RoomController on _RoomControllerBase, Store {
  late final _$roomListAtom =
      Atom(name: '_RoomControllerBase.roomList', context: context);

  @override
  List<RoomResponseModel>? get roomList {
    _$roomListAtom.reportRead();
    return super.roomList;
  }

  @override
  set roomList(List<RoomResponseModel>? value) {
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

  @override
  String toString() {
    return '''
roomList: ${roomList}
    ''';
  }
}
