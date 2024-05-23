import 'package:cochinito_flutter/screens/configuracion_general_screen.dart';
import 'package:cochinito_flutter/screens/reporte_creditos_screen.dart';
import 'package:cochinito_flutter/screens/solicitud_creditos_nomina_screen.dart';
import 'package:flutter/material.dart';
import 'package:cochinito_flutter/screens/screens.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => const CheckAuthScreen(),
    '/login': (BuildContext context) => const LoginScreen(),
    '/home': (BuildContext context) => const HomeScreen(),
    '/gestionUsuarios': (BuildContext context) => const GestionUsuariosScreen(),
    '/registroUsuario': (BuildContext context) => const RegistroScreen(),
    '/calendarioBancario': (BuildContext context) => const CalendarioBancarioScreen(),
    '/gestionEmpresas': (BuildContext context) => const GestionEmpresasScreen(),
    '/configuracionesEmpresa': (BuildContext context) => const ConfiguracionEmpresaScreen(),
	  '/registroEmpresa': (BuildContext context) => const RegistroEmpresasScreen(),
    '/condicionesCredito': (BuildContext context) => const CondicionesCreditoScreen(),
    '/registroCondicionesCredito': (BuildContext context) => const RegistroCondicionesCreditoScreen(),
    '/creditosNomina': (BuildContext context) => const CreditosNominaScreen(),
    '/consultaCredito': (BuildContext context) => const ConsultaCreditos(),
    '/reportesCredito': (BuildContext context) => const ReporteCreditosScreen(),
    '/configuracionGeneral': (BuildContext context) => const ConfiguracionGeneralScreen(),
    '/solicitudCreditosNomina': (BuildContext context) => const SolicitudCreditosNominaScreen(),
  };
}
