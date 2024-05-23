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

class RegistroScreen extends StatefulWidget {
  const RegistroScreen({super.key});

  @override
  State<RegistroScreen> createState() => _RegistroScreenState();
}

class _RegistroScreenState extends State<RegistroScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final userService = Provider.of<UsersService>(context, listen: false);
    if (Preferences.idUserConsultar.isNotEmpty) {
      userService.getUsers(idUsuario: int.parse(Preferences.idUserConsultar));
    }
  }

  @override
  Widget build(BuildContext context) {
    final rolService = Provider.of<RolService>(context, listen: false);
    final nominaService = Provider.of<NominaService>(context, listen: false);
    final empresaService = Provider.of<EmpresaService>(context, listen: false);
    final userService = Provider.of<UsersService>(context, listen: true);
    //final preferences = Preferences();
    //Urls.initUrls(preferences.ip==''?'192.168.100.9/BLMovil/Residencial/trunk/src/App%20web/BLMResidencial/public':preferences.ip);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
          ),
          onPressed: () =>
              Navigator.pushReplacementNamed(context, '/gestionUsuarios'),
        ),
        centerTitle: true,
        title: const Text('Registrar usuario'),
      ),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
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
                    userService: userService),
              ),
            ],
          ),
        ),
      ),
      /* ), */
    );
  }
}

class _RegisterForm extends StatefulWidget {
  final Future<List<RolModel>> roles;
  final Future<List<TipoNominaModel>> nominas;
  final Future<List<EmpresaModel>> empresas;
  final UsersService userService;
  _RegisterForm({
    required this.roles,
    required this.nominas,
    required this.empresas,
    required this.userService,
  });

  @override
  State<_RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<_RegisterForm> {
  final TextEditingController nombreController = TextEditingController();

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

  String userid = '';

  int rolId = 0;

  int nominaId = 0;

  int empresaId = 0;

  bool contratoFirmado = false;

  @override
  Widget build(BuildContext context) {
    debugPrint('longitud: ${widget.userService.users.length} bandera: $bandera');
    if (Preferences.idUserConsultar.isNotEmpty && widget.userService.users.length == 1  && bandera) {
      
      bandera = false;
      userid = Preferences.idUserConsultar;
      rolId = widget.userService.users[0].rolId!;
      empresaId = widget.userService.users[0].empresaId ?? 0;
      contratoFirmado = widget.userService.users[0].contratoFirmado == 'true' ? true : false ;
      nombreController.text = widget.userService.users[0].nombre.toString();
      nominaId = widget.userService.users[0].nominaId ?? 0;
      apellidoPaternoController.text =
          widget.userService.users[0].apellidoPaterno.toString();

      apellidoMaternoController.text =
          widget.userService.users[0].apellidoMaterno.toString();

      rfcController.text = widget.userService.users[0].rfc.toString();

      emailController.text = widget.userService.users[0].email.toString();

      nominaController.text = widget.userService.users[0].nomina.toString();

      telefonoPrincipalController.text =
          widget.userService.users[0].telefonoPrincipal.toString();

      telefonoSecundarioController.text =
          widget.userService.users[0].telefonoSecundario.toString();
    }
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
          Container(
            decoration: const BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.qr_code_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                try {
                  final scanQR = await scanQr(context);
                  debugPrint(scanQR);
                  if (scanQR != '-1') {
                    List<String> part = scanQR.split("&D3=");
                    if (part.length >= 2) {
                      final rfc = part[1];
                      var data = await qrService.obtenerDatosRFC(rfc);
                      if (data != null) {
                        if (context.mounted) {
                          Flushbar(
                            backgroundColor: AppColors.successColor,
                            message: 'Fin del proceso',
                            duration: const Duration(milliseconds: 2000),
                          ).show(context);
                        }
                        ResponseQrModel dataQr = data;
                        final List<String> separaNombre =
                            dataQr.nombre.split(' ');
                        if (separaNombre.length == 3) {
                          nombreController.text = separaNombre[0];
                          apellidoPaternoController.text = separaNombre[1];
                          apellidoMaternoController.text = separaNombre[2];
                        } else if (separaNombre.length == 4) {
                          nombreController.text =
                              '${separaNombre[0]} ${separaNombre[1]}';
                          apellidoPaternoController.text = separaNombre[2];
                          apellidoMaternoController.text = separaNombre[3];
                        } else {
                          nombreController.text = dataQr.nombre;
                        }
                        emailController.text = dataQr.email;
                        rfcController.text = dataQr.rfc;

                        registerForm.nombre = nombreController.text;
                        registerForm.apellidoMaterno =
                            apellidoMaternoController.text;
                        registerForm.apellidoPaterno =
                            apellidoPaternoController.text;
                        registerForm.rfc = rfcController.text;
                        registerForm.email = emailController.text;
                      }
                    }
                  }
                } catch (e) {
                  if (context.mounted) {
                    Flushbar(
                      backgroundColor: AppColors.dangerColor,
                      message: 'Ha ocurrido un error registro_screen',
                      duration: const Duration(milliseconds: 2000),
                    ).show(context);
                  }
                }
              },
            ),
          ),
          FutureBuilder<List<RolModel>>(
            future: widget.roles,
            builder: (context, snapshot) {
              // hide the keyboard if it's showing
              if (snapshot.hasData) {
                List<DropdownMenuItem<String>> dropdownItems = [];

                for (RolModel e in snapshot.data!) {
                  if (Preferences.idRol == "1" ||
                      (Preferences.idRol == "2" && e.id == 3)) {
                    dropdownItems.add(DropdownMenuItem(
                      value: e.id.toString(),
                      child: Text(e.tipoRol),
                    ));
                  }
                }

                if (dropdownItems.isEmpty) {
                  // Handle the case where there are no valid items to display.
                  // You can either return an empty DropdownButtonFormField or
                  // a placeholder indicating that there are no options available.
                  return DropdownButtonFormField(
                    items: [],
                    onChanged: (value) {},
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Tipo de usuario',
                      prefixIcon: Icons.people_rounded,
                    ),
                  );
                }

                return DropdownButtonFormField(
                  isExpanded: true,
                  hint: const Text("Seleccione tipo de usuario"),
                  decoration: InputDecorations.inputDecoration(
                    hintText: '',
                    labelText: 'Tipo de usuario',
                    prefixIcon: Icons.people_rounded,
                  ),
                  items: dropdownItems,
                  onChanged: (value) {
                    if (value != null) {
                      registerForm.rolId = value;
                    }
                  },
                  value: rolId > 0 ? rolId.toString() : dropdownItems[0].value,
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Completa el campo' : null,
                );
              } else if (snapshot.hasError) {
                return Text("Error: ${snapshot.error}");
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
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
          TextFormField(
            controller: apellidoPaternoController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Apellido paterno',
              prefixIcon: Icons.person_2_rounded,
            ),
            onChanged: (value) {
              registerForm.apellidoPaterno = value;
            },
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          TextFormField(
            controller: apellidoMaternoController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Apellido materno',
              prefixIcon: Icons.person_3_rounded,
            ),
            onChanged: (value) => registerForm.apellidoMaterno = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          TextFormField(
            controller: rfcController,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'RFC',
              prefixIcon: Icons.class_rounded,
            ),
            onChanged: (value) => registerForm.rfc = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          TextFormField(
            controller: emailController,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Email',
              prefixIcon: Icons.alternate_email_rounded,
            ),
            onChanged: (value) => registerForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return (value == null || value.isEmpty)
                  ? 'Completar el campo'
                  : regExp.hasMatch(value) //regExp.hasMatch(value ?? '')
                      ? null
                      : 'Correo inválido';
            },
          ),
          registerForm.rolId != '3'
              ? Container()
              : TextFormField(
                  controller: nominaController,
                  autocorrect: false,
                  keyboardType: TextInputType.number,
                  decoration: InputDecorations.inputDecoration(
                    hintText: '',
                    labelText: 'Nómina',
                    prefixIcon: Icons.monetization_on_rounded,
                  ),
                  onChanged: (value) => registerForm.nomina = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
          TextFormField(
            controller: telefonoPrincipalController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Teléfono Principal',
              prefixIcon: Icons.phone,
            ),
            onChanged: (value) => registerForm.telefonoPrincipal = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          TextFormField(
            controller: telefonoSecundarioController,
            autocorrect: false,
            keyboardType: TextInputType.number,
            decoration: InputDecorations.inputDecoration(
              hintText: '',
              labelText: 'Teléfono Secundario',
              prefixIcon: Icons.phone_outlined,
            ),
            onChanged: (value) => registerForm.telefonoSecundario = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          const SizedBox(height: 20),
          registerForm.rolId != '3'
              ? Container()
              : FutureBuilder<List<TipoNominaModel>>(
                  future: widget.nominas,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final n = snapshot.data!;

                      return DropdownButtonFormField(
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: 'Tipo de nomina',
                          prefixIcon: Icons.calendar_view_day_rounded,
                        ),
                        isExpanded: true,
                        hint: const Text("Seleccione tipo de nómina"),
                        items: n.map((e) {
                          return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.tipoNomina),
                          );
                        }).toList(),
                        onChanged: (value) {
                          registerForm.nominaId = value!;
                        },
                        validator: (value) =>
                            value == null ? 'Completa el campo' : null,
                        //value: registerForm.nominaId,
                        value: nominaId != 0 ? nominaId.toString() : null,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
          SizedBox(height: registerForm.rolId == '2' ? 0 : 20),
          registerForm.rolId == '1'
              ? Container()
              : FutureBuilder<List<EmpresaModel>>(
                  future: widget.empresas,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField(
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: 'Empresa',
                          prefixIcon: Icons.business_rounded,
                        ),
                        isExpanded: true,
                        hint: const Text("Seleccione Empresa"),
                        items: snapshot.data!.map((e) {
                          return DropdownMenuItem(
                            value: e.id.toString(),
                            child: Text(e.nombreEmpresa),
                          );
                        }).toList(),
                        onChanged: (value) => registerForm.empresaId = value!,
                        /* validator: (value) => registerForm.empresaId == '0'
                            ? 'Completa el campo'
                            : null, */
                        validator: (value) =>
                            value == null ? 'Completa el campo' : null,
                        value: empresaId != 0 ? empresaId.toString() : null,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
          
          const SizedBox(height: 20),
          Visibility(
            visible:Preferences.idRol=="1",
            child: CheckboxListTile(
              tileColor: Colors.red,
              title: const Text('¿Tiene contrato firmado?'),
              value: contratoFirmado,
              onChanged: (bool? value) {
                setState(() {
                  contratoFirmado = value ?? false;
                  registerForm.contrato = contratoFirmado; // Actualiza el estado del formulario
                });
              },
            ),
          ),
          const SizedBox(height: 25),
          ElevatedButton(
            onPressed: registerForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!registerForm.isValidForm()) return;
                    registerForm.isLoading = true;
                    final String? errorMessage = await authService.registro(
                        userid,
                        nombreController.text,
                        apellidoPaternoController.text,
                        apellidoMaternoController.text,
                        telefonoPrincipalController.text,
                        telefonoSecundarioController.text,
                        nominaController.text,// nomina $
                        registerForm.nominaId,//Tipo de nomina
                        registerForm.rolId,
                        registerForm.empresaId,
                        rfcController.text,
                        emailController.text,
                        registerForm.contrato.toString());
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
          /* 
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/gestionUsuarios');
            },
            child: const Text('Cancelar'),
          ), */
        ],
      ),
    );
  }

  Future<String> scanQr(context) async {
    try {
      final scanQR = await FlutterBarcodeScanner.scanBarcode(
        '#31F9CC',
        'Salir',
        false,
        ScanMode.QR,
      );
      return scanQR;
    } catch (e) {
      return '-1'; // Retorna un valor que indica un error
    }
  }
}
