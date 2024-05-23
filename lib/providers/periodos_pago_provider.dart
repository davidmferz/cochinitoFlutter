import 'package:flutter/material.dart';

class PeriodosPagoProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  

  int _nominaId = 0;
  int _diaMensual = 0;
  int _primerDiaQuincena = 0;
  int _segundoDiaQuincena = 0;
  int _diaCatorcena = 0;
  String _tipoCatorcena = 'pares'; //pares - impares
  int _diaSemanal = 0;

  bool _isLoading = false;

  int get getNominaId => _nominaId;
  set setNominaId(int nominaId) {
    _nominaId = nominaId;
    
    notifyListeners();
  }

  int get getDiaMensual => _diaMensual;
  set setDiaMensual(int diaMensual) {
    _diaMensual = diaMensual;
    notifyListeners();
  }

  int get getPrimerDiaQuincena => _primerDiaQuincena;
  set setPrimerDiaQuincena(int primerDiaQuincena) {
    _primerDiaQuincena = primerDiaQuincena;
    notifyListeners();
  }

  int get getSegundoDiaQuincena => _segundoDiaQuincena;
  set setSegundoDiaQuincena(int segundoDiaQuincena) {
    _segundoDiaQuincena = segundoDiaQuincena;
    notifyListeners();
  }

  int get getDiaCatorcena => _diaCatorcena;
  set setDiaCatorcena(int diaCatorcena) {
    _diaCatorcena = diaCatorcena;
    notifyListeners();
  }

  String get getTipoCatorcena => _tipoCatorcena;
  set setTipoCatorcena(String tipoCatorcena) {
    _tipoCatorcena = tipoCatorcena;
    notifyListeners();
  }

  int get getDiaSemanal => _diaSemanal;
  set setDiaSemanal(int diaSemanal) {
    _diaSemanal = diaSemanal;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
