import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  //static final Preferences _instancia = Preferences._();
  static late SharedPreferences _preferences;
  static String _idUser = '';
  static String _idEmpresa = '';
  static String _firebaseToken = '';
  static String _nombreUser = '';
  static String _idRol = '';
  static String _nameRol = '';
  static String _nameEmpresa = '';
  static String _idUserConsultar = '';
  static String _porcentajeMaximo = '';
  static String _plazoMaximo= '';
  static String _empresaSelect= '';
  static String _nominaTotal= '';
  static String _totalGeneral= '0';
  static String _ultimaFecha = '';

  Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static set idUser(String idUser) {
    _idUser = idUser;
    _preferences.setString('idUser', idUser);
  }

  static String get idUser => _preferences.getString('idUser') ?? _idUser;

  static set ultimaFecha(String ultimaFecha) {
    _ultimaFecha = ultimaFecha;
    _preferences.setString('ultimaFecha', ultimaFecha);
  }

  static String get ultimaFecha => _preferences.getString('ultimaFecha') ?? _ultimaFecha;

  static set nominaTotal(String nominaTotal) {
    _nominaTotal = nominaTotal;
    _preferences.setString('nominaTotal', nominaTotal);
  }

  static String get nominaTotal => _preferences.getString('nominaTotal') ?? _nominaTotal;

  static set porcentajeMaximo(String porcentajeMaximo) {
    _porcentajeMaximo = porcentajeMaximo;
    _preferences.setString('porcentajeMaximo', porcentajeMaximo);
  }

  static String get porcentajeMaximo => _preferences.getString('porcentajeMaximo') ?? _porcentajeMaximo;

  static set plazoMaximo(String plazoMaximo) {
    _plazoMaximo = plazoMaximo;
    _preferences.setString('plazoMaximo', plazoMaximo);
  }

  static String get plazoMaximo => _preferences.getString('plazoMaximo') ?? _plazoMaximo;

  static set idEmpresa(String idEmpresa) {
    _idEmpresa = idEmpresa;
    _preferences.setString('idEmpresa', idEmpresa);
  }

  static String get idEmpresa =>
      _preferences.getString('idEmpresa') ?? _idEmpresa;

  static set firebaseToken(String token) {
    _firebaseToken = token;
    _preferences.setString('firebaseToken', token);
  }

  static String get firebaseToken =>
      _preferences.getString('firebaseToken') ?? _firebaseToken;

  static set nombreUser(String nombreUser) {
    _nombreUser = nombreUser;
    _preferences.setString('nombreUser', nombreUser);
  }

  static String get nombreUser =>
      _preferences.getString('nombreUser') ?? _nombreUser;

  static set idRol(String idRol) {
    _idRol = idRol;
    _preferences.setString('idRol', idRol);
  }

  static String get idRol => _preferences.getString('idRol') ?? _idRol;

  static set nameRol(String nameRol) {
    _nameRol = nameRol;
    _preferences.setString('nameRol', nameRol);
  }

  static String get nameRol => _preferences.getString('nameRol') ?? _nameRol;

  static set nameEmpresa(String nameEmpresa) {
    _nameEmpresa = nameEmpresa;
    _preferences.setString('nameEmpresa', nameEmpresa);
  }

  static String get nameEmpresa =>
      _preferences.getString('nameEmpresa') ?? _nameEmpresa;

  static set idUserConsultar(String idUserConsultar) {
    _idUserConsultar = idUserConsultar;
    _preferences.setString('idUserConsultar', idUserConsultar);
  }

  static String get idUserConsultar =>
      _preferences.getString('idUserConsultar') ?? _idUserConsultar;

  static set empresaSelect(String empresaSelect) {
    _empresaSelect = empresaSelect;
    _preferences.setString('empresaSelect', empresaSelect);
  }

  static String get empresaSelect =>
      _preferences.getString('empresaSelect') ?? _empresaSelect;

  static set totalGeneral(String totalGeneral) {
    _idRol = totalGeneral;
    _preferences.setString('totalGeneral', totalGeneral);
  }

  static set idEmpresaConsultar(String idEmpresaConsultar) {
    idEmpresaConsultar = idEmpresaConsultar;
    _preferences.setString('idEmpresaConsultar', idEmpresaConsultar);
  }

  static String get idEmpresaConsultar =>
      _preferences.getString('idEmpresaConsultar') ?? idEmpresaConsultar;

  static String get totalGeneral => _preferences.getString('totalGeneral') ?? _idRol;
}

