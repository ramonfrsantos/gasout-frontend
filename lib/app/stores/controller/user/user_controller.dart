import 'dart:async';

import 'package:gas_out_app/data/model/login/login_response_model.dart';
import 'package:mobx/mobx.dart';
part 'user_controller.g.dart';

class UserController = _UserControllerBase
    with _$UserController;

abstract class _UserControllerBase with Store {
  @observable
  String? username;

  @action
  setValue(String value) {
    username = value;
  }
}
