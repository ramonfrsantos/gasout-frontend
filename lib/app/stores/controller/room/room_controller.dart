import 'package:gas_out_app/data/repositories/room/room_repository.dart';
import 'package:mobx/mobx.dart';

import '../../../../data/model/room/room_response_model.dart';
part 'room_controller.g.dart';

class RoomController = _RoomControllerBase with _$RoomController;

abstract class _RoomControllerBase with Store {
  RoomRepository _repository = RoomRepository();

  @observable
  bool sprinklersValue = false;

  @observable
  bool sprinklersSwitchHandle = false;

  @observable
  bool alarmValue = false;

  @observable
  bool alarmSwitchHandle = false;

  @observable
  bool notificationValue = false;

  @observable
  bool notificationSwitchHandle = false;

  @observable
  String roomNameObservable = "";

  @action
  setSprinklersValue(bool value) {
    sprinklersValue = value;
  }

  @action
  setSprinklersSwitchHandle(bool value) {
    sprinklersSwitchHandle = value;
  }

  @action
  setAlarmValue(bool value) {
    alarmValue = value;
  }

  @action
  setAlarmSwitchHandle(bool value) {
    alarmSwitchHandle = value;
  }

  @action
  setNotificationValue(bool value) {
    notificationValue = value;
  }

  @action
  setNotificationSwitchHandle(bool value) {
    notificationSwitchHandle = value;
  }

  @action
  setRoomNameObservable(String value) {
    roomNameObservable = value;
  }

  @observable
  List<DataRoom>? roomList = [];

  @observable
  DataRoom? userRoom;

  @action
  getUserRooms(String? login, String roomName) async {
    roomList = await _repository.getUserRooms(login!, roomName);
    print(roomList);
  }

  @action
  sendRoomSensorValue(String name, String email, bool alarmOn,
      bool notificationOn, bool sprinklersOn, int sensorValue) async {
    await _repository.sendRoomSensorValue(
        name, email, alarmOn, notificationOn, sprinklersOn, sensorValue);
  }
}
