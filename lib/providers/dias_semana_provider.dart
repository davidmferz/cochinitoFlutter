import 'package:cochinito_flutter/models/dias_semana_model.dart';
import 'package:flutter/material.dart';

class DiasSemanaProvider extends ChangeNotifier {
  List<DiasSemanaModel> _dias = [];
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  List<DiasSemanaModel> get dias => _dias;
  set dias(List<DiasSemanaModel> dias) {
    _dias = dias;
    notifyListeners();
  }
  
}
