import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/condiciones_credito_service.dart';
import 'package:cochinito_flutter/services/reporteEmpresa_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/* import 'package:cochinito_flutter/providers/providers.dart'; */
import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
 );

  if(kDebugMode){
    //Remove this method to stop OneSignal Debugging
    OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  }

  OneSignal.initialize("2c4b936b-e1d0-419f-a280-a410407d3246");

  // The promptForPushNotificationsWithUserResponse function will show the iOS or Android push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.Notifications.requestPermission(true);

  final preferences = Preferences();
  await preferences.init();
  //String token = await FirebaseService.initializeApp();
  await FirebaseService.initializeApp();
  /* Preferences.firebaseToken = token; */
  runApp(AppState());
}

class AppState extends StatelessWidget {
  AppState({super.key});

  final preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (_) => AuthService(),
      ),
      ChangeNotifierProvider(
        create: (_) => NominaService(),
      ),
      ChangeNotifierProvider(
        create: (_) => EmpresaService(),
      ),
      ChangeNotifierProvider(
        create: (_) => RolService(),
      ),
      ChangeNotifierProvider(
        create: (_) => CalendarioBancarioService(),
      ),
      ChangeNotifierProvider(
        create: (_) => UsersService(),
      ),
      ChangeNotifierProvider(
        create: (_) => CondicionesFormProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PeriodosPagoService(),
      ),
      ChangeNotifierProvider(
        create: (_) => CreditosNominaService(),
      ),
      ChangeNotifierProvider(create: (_) => CondicionesCreditoService()),
      ChangeNotifierProvider(
        create: (_) => EmpresaReporteService(),
      ),
      ChangeNotifierProvider(
        create: (_) => ConfiguracionesGeneralesService(),
      ),
    ], child: const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  final GlobalKey<ScaffoldMessengerState> messengerKey =
      GlobalKey<ScaffoldMessengerState>();
  @override
  void initState() {
    super.initState();
    /* debugPrint('oneSignal: ');
    debugPrint(OneSignal.User.pushSubscription.id); */
    FirebaseService.messagesStream.listen((message) {
      final snackBar = SnackBar(
        content: Text(message),
        backgroundColor: AppColors.primaryColor,
        duration: const Duration(milliseconds: 10000),
      );
      messengerKey.currentState?.showSnackBar(snackBar);
      final rolId = Preferences.idRol;
      navigatorKey.currentState?.pushNamed('/creditosNomina');
      /* if(rolId != '2'){
      }else{
        navigatorKey.currentState?.pushNamed('/consultaCredito');
      } */
      /* NotificationsService.messengerKey.currentState!.showSnackBar(snack); */
    });
    //initPlatformState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'El cochinito de México',
      scaffoldMessengerKey: messengerKey,
      navigatorKey: navigatorKey,
      initialRoute: '/',
      routes: getApplicationRoutes(),
    );
  }

  Future<void> initPlatformState() async {
    String idNotificacion = OneSignal.User.pushSubscription.id.toString();
    dynamic platform = getPlatform(idNotificacion);
    /* debugPrint(platform.toString()); */
  }

  Future<String> getPlatform(String idNotificacion) async {
    if (Platform.isIOS) {
      final authService = Provider.of<AuthService>(context, listen: false);
      await authService.registroEmpresas('Test 3030','');

      return 'iOS : $idNotificacion';
    } else if (Platform.isAndroid) {
      return 'Android';
    } else {
      return 'Otro';
    }
  }
}
