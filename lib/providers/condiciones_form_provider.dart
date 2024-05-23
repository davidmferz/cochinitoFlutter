import 'package:flutter/material.dart';

class CondicionesFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  int _idEmpresa = 0;
  int _porcentaje = 0;
  int _plazo = 0;
  int _interes = 0;

  int get idEmpresa => _idEmpresa;
  set idEmpresa(int value) {
    _idEmpresa = value;
    notifyListeners();
  }

  int get porcentaje => _porcentaje;
  set porcentaje(int value) {
    _porcentaje = value;
    notifyListeners();
  }

  int get plazo => _plazo;
  set plazo(int value) {
    _plazo = value;
    notifyListeners();
  }

  int get interes => _interes;
  set interes(int value) {
    _interes = value;
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
