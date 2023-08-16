import 'package:gas_out_app/data/repositories/room/room_repository.dart';
import 'package:mobx/mobx.dart';

import '../../../../data/model/room/room_response_model.dart';
part 'room_controller.g.dart';

class RoomController = _RoomControllerBase with _$RoomController;

abstract class _RoomControllerBase with Store {
  RoomRepository _repository = RoomRepository();

  @observable
  bool sprinklersValue = false;

  @action
  setSprinklersValue(bool value) {
    sprinklersValue = value;
  }

  @observable
  List<DataRoom>? roomList = [];

  @action
  getUserRooms(String? login) async {
    roomList = await _repository.getUserRooms(login!);
    print(roomList);
  }

  @action
  sendRoomSensorValue(String name, String email, bool alarmOn,
      bool notificationOn, bool sprinklersOn, int sensorValue) async {
    await _repository.sendRoomSensorValue(
        name, email, alarmOn, notificationOn, sprinklersOn, sensorValue);
  }
}
