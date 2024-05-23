import 'package:flutter/material.dart';

class CreditosNominaProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _statusId = '';
  String _anticipo = '';
  bool _puedeSolicitar = true;
  String _calculoPorcentaje = '';
  /* String _porcentaje = '';
  String _calculoNomina = ''; */

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  } 

  bool get puedeSolicitar => _puedeSolicitar;
  set puedeSolicitar(bool value) {
    _puedeSolicitar = value;
    notifyListeners();
  } 
  
  String get anticipo => _anticipo;

  set anticipo(String value) {
    _anticipo = value;
    notifyListeners();
  }

  String get calculoPorcentaje => _calculoPorcentaje;

  set calculoPorcentaje(String value) {
    _calculoPorcentaje = value;
    notifyListeners();
  }
  /* String get porcentaje => _porcentaje;

  set porcentaje(String value) {
    _porcentaje = value;
    notifyListeners();
  }

  String get calculoNomina => _calculoNomina;

  set calculoNomina(String value) {
    _calculoNomina = value;
    notifyListeners();
  } */

  String get status => _statusId;
  set status(String status) {
    _statusId = status;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
