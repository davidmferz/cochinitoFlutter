// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/qr_service.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/home_work_area.dart';

class RegistroEmpresasScreen extends StatefulWidget {
  const RegistroEmpresasScreen({super.key});

  @override
  State<RegistroEmpresasScreen> createState() => _RegistroEmpresasScreenState();
}

class _RegistroEmpresasScreenState extends State<RegistroEmpresasScreen> {
  String? nombreEmpresa;
  late TextEditingController nombreController;
  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController();
    obtenerNombreEmpresa();
  }

Future<void> obtenerNombreEmpresa() async {
  final empresaService = Provider.of<EmpresaService>(context, listen: false);
  final empresas = await empresaService.getEmpresa(idEmpresa: int.parse(Preferences.idEmpresaConsultar)); 
  if (empresas != null ) { // Verifica si la lista no es nula y no está vacía
    nombreEmpresa = empresas.nombreEmpresa;
    nombreController.text = nombreEmpresa ?? '';
    debugPrint(nombreEmpresa ?? '');
    setState(() {});
  } else {
    nombreEmpresa = 'Empresa no encontrada';
    nombreController.text = nombreEmpresa ?? '';
    setState(() {});
  }
}





  @override
  Widget build(BuildContext context) {
    final rolService = Provider.of<RolService>(context, listen: false);
    final nominaService = Provider.of<NominaService>(context, listen: false);
    final empresaService = Provider.of<EmpresaService>(context, listen: true);

    //final preferences = Preferences();
    //Urls.initUrls(preferences.ip==''?'192.168.100.9/BLMovil/Residencial/trunk/src/App%20web/BLMResidencial/public':preferences.ip);
    return Scaffold(
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Text(
                'Registro empresa',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30,
              ),
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
                  roles: rolService.getRoles(),
                  nominas: nominaService.getTipoNominas(),
                  empresas: empresaService.getEmpresas(),
                  empresaService: empresaService,
                  nombreController: nombreController,
                  
                ),
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
  final Future<List<RolModel>> roles;
  final Future<List<TipoNominaModel>> nominas;
  final Future<List<EmpresaModel>> empresas;
  final TextEditingController nombreController;

  final EmpresaService empresaService;
  _RegisterForm({
    required this.roles,
    required this.nominas,
    required this.empresas,
    required this.empresaService,
     required this.nombreController,
  });
  final TextEditingController apellidoPaternoController =
      TextEditingController();
  final TextEditingController apellidoMaternoController =
      TextEditingController();
  final TextEditingController rfcController = TextEditingController();
  final TextEditingController nominaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telefonoPrincipalController =
      TextEditingController();
  final TextEditingController telefonoSecundarioController =
      TextEditingController();
  final String scanBarcode = "0";
  List<TipoNominaModel> nominasUser = [];
  List<TipoNominaModel> nominasAdminEmpresa = [];
  bool bandera = true;
  String nombreEmpresa = '';

  @override
  Widget build(BuildContext context) {
    final registerForm = Provider.of<RegisterFormProvider>(
      context,
    );
    
    final qrService = Provider.of<QrService>(context);
    /* FocusScope.of(context).requestFocus(FocusNode()); */
    return Form(
      key: registerForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: nombreController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Nombre',
              prefixIcon: Icons.person_rounded,
            ),
            onChanged: (value) => registerForm.nombre = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    final String? errorMessage =
                        await authService.registroEmpresas(
                      registerForm.nombre,
                      Preferences.idEmpresaConsultar,
                    );
                    if (context.mounted) {
                      if (errorMessage == null) {
                        Flushbar(
                          backgroundColor: AppColors.successColor,
                          message: 'Registro guardado correctamente',
                          duration: const Duration(milliseconds: 2000),
                        ).show(context);
                      } else {
                        Flushbar(
                          backgroundColor: AppColors.dangerColor,
                          message: errorMessage,
                          duration: const Duration(milliseconds: 2000),
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
                Text(registerForm.isLoading ? 'Espere...' : 'Registrar')
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gestionEmpresas');
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
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
