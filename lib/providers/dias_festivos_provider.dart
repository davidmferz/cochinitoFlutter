import 'package:flutter/material.dart';

class DiasFestivosProvider extends ChangeNotifier {

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String _fecha = '';
  bool _isLoading = false;
  
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }


  String get fecha => _fecha;
  set dias(String fecha) {
    _fecha = fecha;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
  
}

