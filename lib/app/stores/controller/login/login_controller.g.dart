// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$LoginController on _LoginControllerBase, Store {
  Computed<bool>? _$isSignUpButtonEnabledComputed;

  @override
  bool get isSignUpButtonEnabled => (_$isSignUpButtonEnabledComputed ??=
          Computed<bool>(() => super.isSignUpButtonEnabled,
              name: '_LoginControllerBase.isSignUpButtonEnabled'))
      .value;
  Computed<bool>? _$isCreateNewPasswordButtonEnabledComputed;

  @override
  bool get isCreateNewPasswordButtonEnabled =>
      (_$isCreateNewPasswordButtonEnabledComputed ??= Computed<bool>(
              () => super.isCreateNewPasswordButtonEnabled,
              name: '_LoginControllerBase.isCreateNewPasswordButtonEnabled'))
          .value;

  late final _$nameAtom =
      Atom(name: '_LoginControllerBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_LoginControllerBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginControllerBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$confirmPasswordAtom =
      Atom(name: '_LoginControllerBase.confirmPassword', context: context);

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.reportRead();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.reportWrite(value, super.confirmPassword, () {
      super.confirmPassword = value;
    });
  }

  late final _$doLoginAsyncAction =
      AsyncAction('_LoginControllerBase.doLogin', context: context);

  @override
  Future<LoginResponseModel?> doLogin(String login, String password) {
    return _$doLoginAsyncAction.run(() => super.doLogin(login, password));
  }

  late final _$_LoginControllerBaseActionController =
      ActionController(name: '_LoginControllerBase', context: context);

  @override
  String? getErrorPassword(String text) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.getErrorPassword');
    try {
      return super.getErrorPassword(text);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? getErrorName(String text) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.getErrorName');
    try {
      return super.getErrorName(text);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? getErrorEmail(String text) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.getErrorEmail');
    try {
      return super.getErrorEmail(text);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String? getErrorConfirmPassword(
      String textPassword, String textConfirmPassword) {
    final _$actionInfo = _$_LoginControllerBaseActionController.startAction(
        name: '_LoginControllerBase.getErrorConfirmPassword');
    try {
      return super.getErrorConfirmPassword(textPassword, textConfirmPassword);
    } finally {
      _$_LoginControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
email: ${email},
password: ${password},
confirmPassword: ${confirmPassword},
isSignUpButtonEnabled: ${isSignUpButtonEnabled},
isCreateNewPasswordButtonEnabled: ${isCreateNewPasswordButtonEnabled}
    ''';
  }
}
