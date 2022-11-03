// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$UserController on _UserControllerBase, Store {
  late final _$usernameAtom =
      Atom(name: '_UserControllerBase.username', context: context);

  @override
  String? get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String? value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$_UserControllerBaseActionController =
      ActionController(name: '_UserControllerBase', context: context);

  @override
  dynamic setValue(String value) {
    final _$actionInfo = _$_UserControllerBaseActionController.startAction(
        name: '_UserControllerBase.setValue');
    try {
      return super.setValue(value);
    } finally {
      _$_UserControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
username: ${username}
    ''';
  }
}
