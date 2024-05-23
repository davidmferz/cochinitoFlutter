// import 'package:blmagentes/helpers/helpers.dart';
// import 'package:flutter/gestures.dart';
class Urls {
  //static const String _baseUrl = 'http://192.168.0.8/blmovil/BLMResidencial-master/public/api';
  // static const String baseUrl =
  //     'http://192.168.1.6/Residencial/BLMResidencial-master/public/api';
  // static const String baseAsset =
  //     'http://192.168.1.6/Residencial/BLMResidencial-master/storage/app/public';
  static String baseUrl = '';
  static String login = '';
  static String nominas = '';
  static String registerToken = '';
  static String registroIdNotificacion = '';
  static String user = '';
  static String getRFC = '';
  static String decodeQR = '';
  static String empresa = '';
  static String reporteEmpresa = '';
  static String tipoNomina = '';
  static String mailSettings = '';
  static String userDirecciones = '';
  static String diasFestivos = '';
  static String diasLaborales = '';
  static String periodosPago = '';
  static String roles = '';
  static String condicionesCredito = '';
  static String creditosNomina = '';
  static String statusCreditosNomina = '';
  static String verificarCredito = '';
  static String modificarEstadoCredito = '';
  static String enviarCorreoPrueba = '';
  static String getReporteCreditosUsuarios = '';
  static String getSolicitudCreditosNomina = '';
  static String eliminarCredito = '';
  static void buildURL() {
    //baseUrl = 'https://ead7-201-124-161-152.ngrok-free.app/api';
    //baseUrl = 'https://f66f-2806-107e-c-5a50-74e0-95e-5a1c-122.ngrok-free.app/api';
    //baseUrl = 'https://c06d-200-68-173-139.ngrok-free.app/api';
    baseUrl = 'http://74.208.200.52/cochinito_laravel/public/api';
    login = '$baseUrl/auth/login';
    user = '$baseUrl/user';
    registerToken = '$baseUrl/firebase/registerToken';
    registroIdNotificacion = '$baseUrl/registroIdNotificacion';
    getRFC = '$baseUrl/getRFC';
    empresa = '$baseUrl/empresa';
    tipoNomina = '$baseUrl/tipo_nomina';
    mailSettings = '$baseUrl/mail_settings';
    userDirecciones = '$baseUrl/user_direcciones';
    diasFestivos = '$baseUrl/dias_festivos';
    diasLaborales = '$baseUrl/dias_laborales';
    roles = '$baseUrl/roles';
    /* registerToken = '$baseUrl/agente/registerToken';
    decodeQR = '$baseUrl/agente/decodificarQrFlutter';     */
    condicionesCredito = '$baseUrl/condiciones';
    periodosPago = '$baseUrl/periodos_pago';
    creditosNomina = '$baseUrl/creditos_nomina';
    statusCreditosNomina = '$baseUrl/status_creditos_nomina';
    modificarEstadoCredito = '$baseUrl/modificar_estado_credito';
    verificarCredito = '$baseUrl/verificar_credito';
    enviarCorreoPrueba = '$baseUrl/enviar_correo_prueba';
    getReporteCreditosUsuarios = '$baseUrl/get_reporte_creditos_usuarios';
    reporteEmpresa = '$baseUrl/getReporteCreditosEmpresa';
    getSolicitudCreditosNomina = '$baseUrl/get_solicitud_creditos_nomina';
    eliminarCredito = '$baseUrl/eliminar_creditos_nomina';
  }
}
