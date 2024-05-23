import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String _nombre = '';
  String _apellidoPaterno = '';
  String _apellidoMaterno = '';
  String _telefonoPrincipal = '';
  String _telefonoSecundario = '';
  String _nomina = '';
  String _nominaId = '0';
  String _rolId = '3';
  String _empresaId = '0';
  String _rfc = '';
  String _email = '';
  bool _contrato=false;

  String get nombre => _nombre;
  set nombre(String value) {
    _nombre = value;
    notifyListeners();
  }

  String get apellidoPaterno => _apellidoPaterno;
  set apellidoPaterno(String value) {
    _apellidoPaterno = value;
    notifyListeners();
  }

  String get apellidoMaterno => _apellidoMaterno;
  set apellidoMaterno(String value) {
    _apellidoMaterno = value;
    notifyListeners();
  }

  String get telefonoPrincipal => _telefonoPrincipal;
  set telefonoPrincipal(String value) {
    _telefonoPrincipal = value;
    notifyListeners();
  }

  String get telefonoSecundario => _telefonoSecundario;
  set telefonoSecundario(String value) {
    _telefonoSecundario = value;
    notifyListeners();
  }

  String get nomina => _nomina;
  set nomina(String value) {
    _nomina = value;
    notifyListeners();
  }

  String get nominaId => _nominaId;
  set nominaId(String value) {
    _nominaId = value;
    notifyListeners();
  }

  String get rolId => _rolId;
  set rolId(String value) {
    _rolId = value;
    notifyListeners();
  }

  String get empresaId => _empresaId;
  set empresaId(String value) {
    _empresaId = value;
    notifyListeners();
  }

  String get rfc => _rfc;
  set rfc(String value) {
    _rfc = value;
    notifyListeners();
  }

  String get email => _email;
  set email(String value) {
    _email = value;
    notifyListeners();
  }

  bool get contrato => _contrato;
  set contrato(bool value) {
    _contrato = value;
    notifyListeners();
  }

  //para saber si ya termino de cargar despues de dar clic en registrar
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
