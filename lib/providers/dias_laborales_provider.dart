import 'package:cochinito_flutter/models/dias_laborales_model.dart';
import 'package:flutter/material.dart';

class DiasLaboralesProvider extends ChangeNotifier {
  List<DiasLaboralesModel> _dias = [];
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  List<DiasLaboralesModel> get dias => _dias;
  set dias(List<DiasLaboralesModel> dias) {
    _dias = dias;
    notifyListeners();
  }
  
}
