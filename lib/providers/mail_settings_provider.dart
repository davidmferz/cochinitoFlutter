import 'package:flutter/material.dart';

class MailSettingsProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  GlobalKey<FormState> formKeyTest = GlobalKey<FormState>();
  String _mailTest = '';
  String _mailDriver = '';
  String _mailHost = '';
  String _mailPort = '';
  String _mailUserName = '';
  String _mailPassword = '';
  String _mailEncryption = '';
  String _mailFromAddress = '';
  String _mailFromName = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  String get mailTest => _mailTest;

  set mailTest(String value) {
    _mailTest = value;
    notifyListeners();
  }
  String get mailDriver => _mailDriver;

  set mailDriver(String value) {
    _mailDriver = value;
    notifyListeners();
  }

  String get mailHost => _mailHost;

  set mailHost(String value) {
    _mailHost = value;
    notifyListeners();
  }

  String get mailPort => _mailPort;

  set mailPort(String value) {
    _mailPort = value;
    notifyListeners();
  }

  String get mailUserName => _mailUserName;

  set mailUserName(String value) {
    _mailUserName = value;
    notifyListeners();
  }

  String get mailPassword => _mailPassword;

  set mailPassword(String value) {
    _mailPassword = value;
    notifyListeners();
  }

  String get mailEncryption => _mailEncryption;

  set mailEncryption(String value) {
    _mailEncryption = value;
    notifyListeners();
  }

  String get mailFromAddress => _mailFromAddress;

  set mailFromAddress(String value) {
    _mailFromAddress = value;
    notifyListeners();
  }

  String get mailFromName => _mailFromName;

  set mailFromName(String value) {
    _mailFromName = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }

  bool isValidFormTest() {
    return formKeyTest.currentState?.validate() ?? false;
  }
}
