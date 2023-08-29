import 'package:gas_out_app/data/repositories/room/room_repository.dart';
import 'package:mobx/mobx.dart';

import '../../../../data/model/room/room_response_model.dart';
part 'room_controller.g.dart';

class RoomController = _RoomControllerBase with _$RoomController;

abstract class _RoomControllerBase with Store {
  RoomRepository _repository = RoomRepository();

  @observable
  List<DataRoom>? roomList = [];

  @observable
  DataRoom? userRoom;

  @action
  getUserRooms(String? login, int? nameId) async {
    roomList = await _repository.getUserRooms(login!, nameId!);
    print(roomList);
  }

  @action
  updateSwitches(String login, int nameId, bool notificationOn, bool alarmOn, bool sprinklersOn) async {
    await _repository.updateSwitches(login, nameId, notificationOn, alarmOn, sprinklersOn);
  }
}
