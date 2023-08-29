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

  late final _$userRoomAtom =
      Atom(name: '_RoomControllerBase.userRoom', context: context);

  @override
  DataRoom? get userRoom {
    _$userRoomAtom.reportRead();
    return super.userRoom;
  }

  @override
  set userRoom(DataRoom? value) {
    _$userRoomAtom.reportWrite(value, super.userRoom, () {
      super.userRoom = value;
    });
  }

  late final _$getUserRoomsAsyncAction =
      AsyncAction('_RoomControllerBase.getUserRooms', context: context);

  @override
  Future getUserRooms(String? login, int? nameId) {
    return _$getUserRoomsAsyncAction
        .run(() => super.getUserRooms(login, nameId));
  }

  late final _$updateSwitchesAsyncAction =
      AsyncAction('_RoomControllerBase.updateSwitches', context: context);

  @override
  Future updateSwitches(String login, int nameId, bool notificationOn,
      bool alarmOn, bool sprinklersOn) {
    return _$updateSwitchesAsyncAction.run(() => super
        .updateSwitches(login, nameId, notificationOn, alarmOn, sprinklersOn));
  }

  @override
  String toString() {
    return '''
roomList: ${roomList},
userRoom: ${userRoom}
    ''';
  }
}
