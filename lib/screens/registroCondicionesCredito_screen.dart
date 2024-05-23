// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:cochinito_flutter/providers/condiciones_form_provider.dart';
import 'package:cochinito_flutter/screens/condicion_credito_screen.dart';
import 'package:cochinito_flutter/services/condiciones_credito_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/qr_service.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/home_work_area.dart';

class RegistroCondicionesCreditoScreen extends StatelessWidget {
  const RegistroCondicionesCreditoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final parametros =
        ModalRoute.of(context)?.settings.arguments as ParametrosCondiciones?;
    final condicionesCreditoService =
        Provider.of<CondicionesCreditoService>(context, listen: false);
    String nombreEmpresa = "";
    int idEmpresa = 0;
    if (parametros != null) {
      nombreEmpresa = parametros.nombreEmpresa;
      idEmpresa = parametros.idEmpresa;
    }
    //final preferences = Preferences();
    //Urls.initUrls(preferences.ip==''?'192.168.100.9/BLMovil/Residencial/trunk/src/App%20web/BLMResidencial/public':preferences.ip);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home_rounded,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Condiciones credito'),
      ),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(nombreEmpresa, textAlign: TextAlign.left),
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => RegisterFormProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => QrService(),
                  ),
                ],
                child: _RegisterForm(
                    condicionesCreditoService: condicionesCreditoService
                        .getCondicionesCredito(idEmpresa: idEmpresa),
                    idEmpresa: idEmpresa,
                    bandera: true),
              ),
            ],
          ),
        ),
      ),
      /* ), */
    );
  }
}

class _RegisterForm extends StatelessWidget {
  final Future<Object?> condicionesCreditoService;
  int idEmpresa;
  bool bandera;
  _RegisterForm(
      {required this.condicionesCreditoService,
      required this.idEmpresa,
      required this.bandera});

  final TextEditingController porcentajeController = TextEditingController();
  final TextEditingController plazoController = TextEditingController();
  final TextEditingController interesController = TextEditingController();
  TextEditingController idEmpresaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<CondicionesFormProvider>(
      context,
    );
    idEmpresaController.text = idEmpresa.toString();
    return FutureBuilder<Object?>(
        future: condicionesCreditoService,
        initialData: true,
        builder: (context, AsyncSnapshot<Object?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data is Map<String, dynamic> && bandera == true) {
              Map<String, dynamic> responseData =
                  snapshot.data as Map<String, dynamic>;
              porcentajeController.text =
                  responseData['porcentaje']?.toString() ?? '0.0';

              plazoController.text = responseData['plazo']?.toString() ?? '0';

              interesController.text = responseData['interes']?.toString() ?? '0';
              bandera = false;
            }
            idEmpresaController.text = idEmpresa.toString();
            //registerForm.idEmpresa=idEmpresa;
            return Form(
              key: registerForm.formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  TextFormField(
                    controller: porcentajeController,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Porcentaje máximo de la nómina',
                      prefixIcon: Icons.percent,
                    ),
                    onChanged: (value) =>
                    
                        registerForm.porcentaje = value.length > 0? int.parse(value): 0,
                    validator: (value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'Completa el campo';
                    },
                  ),
                  TextFormField(
                    controller: plazoController,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Plazo previo al pago de nómina',
                      prefixIcon: Icons.calendar_month,
                    ),
                    onChanged: (value) =>
                    
                        registerForm.plazo = value.length > 0? int.parse(value): 0,
                    validator: (value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'Completa el campo';
                    },
                  ),
                  TextFormField(
                    controller: interesController,
                    autocorrect: false,
                    keyboardType: TextInputType.number,
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Interes',
                      prefixIcon: Icons.percent,
                    ),
                    onChanged: (value) =>
                    
                        registerForm.interes = value.length > 0? int.parse(value): 0,
                    validator: (value) {
                      return (value != null && value.isNotEmpty)
                          ? null
                          : 'Completa el campo';
                    },
                  ),
                  const SizedBox(height: 30),
                  Visibility(
                    visible: Preferences.idRol == '1',
                    child: ElevatedButton(
                      onPressed: registerForm.isLoading
                          ? null
                          : () async {
                              FocusScope.of(context).unfocus();
                              final authService = Provider.of<AuthService>(
                                  context,
                                  listen: false);
                              if (!registerForm.isValidForm()) return;
                              registerForm.isLoading = true;
                              final String? errorMessage =
                                  await authService.registroCondiciones(
                                idEmpresa,
                                registerForm.porcentaje,
                                registerForm.plazo,
                                registerForm.interes
                              );
                              if (context.mounted) {
                                if (errorMessage == null) {
                                  Flushbar(
                                    backgroundColor: AppColors.successColor,
                                    message: 'Registro guardado correctamente',
                                    duration:
                                        const Duration(milliseconds: 2000),
                                  ).show(context);
                                } else {
                                  Flushbar(
                                    backgroundColor: AppColors.dangerColor,
                                    message: errorMessage,
                                    duration:
                                        const Duration(milliseconds: 2000),
                                  ).show(context);
                                }
                              }
                              registerForm.isLoading = false;
                            },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.save),
                          const SizedBox(width: 20),
                          Text(registerForm.isLoading
                              ? 'Espere...'
                              : 'Registrar')
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/home');
                    },
                    child: const Text('Cancelar'),
                  ),
                ],
              ),
            );
          }
        });
  }

  scanQr(context) {
    FlutterBarcodeScanner.scanBarcode(
      '#31F9CC',
      'Salir',
      false,
      ScanMode.QR,
    );
    //  ;
  }
}
