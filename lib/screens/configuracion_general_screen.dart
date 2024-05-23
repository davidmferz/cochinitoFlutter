import 'package:another_flushbar/flushbar.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';

class ConfiguracionGeneralScreen extends StatelessWidget {
  const ConfiguracionGeneralScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Configuraciones'),
      ),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => MailSettingsProvider(),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _MailSettings(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MailSettings extends StatelessWidget {
  final TextEditingController mailDriverController = TextEditingController();
  final TextEditingController mailHostController = TextEditingController();
  final TextEditingController mailPortController = TextEditingController();
  final TextEditingController mailUserNameController = TextEditingController();
  final TextEditingController mailPasswordController = TextEditingController();
  final TextEditingController mailEncryptionController =
      TextEditingController();
  final TextEditingController mailFromAddressController =
      TextEditingController();
  final TextEditingController mailFromNameController = TextEditingController();
  final TextEditingController mailTestController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final mailSettingsProvider = Provider.of<MailSettingsProvider>(context);
    return Flexible(
      child: Wrap(
        children: [
          const Center(
            child: Text('Gestor de correos'),
          ),
          Form(
            key: mailSettingsProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailDriverController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Protocolo de correo',
                    hintText: 'Ej.: smtp',
                    prefixIcon: Icons.webhook_rounded,
                  ),
                  onChanged: (value) => mailSettingsProvider.mailDriver = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailHostController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Servidor de correo',
                    hintText: 'Ej.: emails.cochinito.com',
                    prefixIcon: Icons.https_rounded,
                  ),
                  onChanged: (value) => mailSettingsProvider.mailHost = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: false,
                    signed: false,
                  ),
                  autocorrect: false,
                  enableSuggestions: false,
                  controller: mailPortController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Puerto',
                    hintText: 'Ej.: 123',
                    prefixIcon: Icons.private_connectivity_rounded,
                  ),
                  onChanged: (value) => mailSettingsProvider.mailPort = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailUserNameController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Nombre de usuario',
                    hintText: 'Ej.: cochinito@cochinito.com',
                    prefixIcon: Icons.person_rounded,
                  ),
                  onChanged: (value) =>
                      mailSettingsProvider.mailUserName = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  obscureText: true,
                  controller: mailPasswordController,
                  autocorrect: false,
                  enableSuggestions: false, 
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Contraseña',
                    hintText: 'Contraseña',
                    prefixIcon: Icons.password_rounded,
                  ),
                  onChanged: (value) =>
                      mailSettingsProvider.mailPassword = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailEncryptionController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Método de encriptación',
                    hintText: 'Ej.: tls',
                    prefixIcon: Icons.enhanced_encryption_rounded,
                  ),
                  onChanged: (value) =>
                      mailSettingsProvider.mailEncryption = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  controller: mailFromAddressController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Correo del remitente',
                    hintText: 'Ej.: cochinito@cochinito.com',
                    prefixIcon: Icons.mail,
                  ),
                  onChanged: (value) =>
                      mailSettingsProvider.mailFromAddress = value,
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
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailFromNameController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Nombre del remitente',
                    hintText: 'Ej.: EL COCHINITO DE MÉXICO',
                    prefixIcon: Icons.person_rounded,
                  ),
                  onChanged: (value) =>
                      mailSettingsProvider.mailFromName = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: mailSettingsProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!mailSettingsProvider.isValidForm()) return;
                      mailSettingsProvider.isLoading = true;
                      /* print(mailSettingsProvider.dias.length.toString()); */
                      final guardarDiasLaborales =
                          Provider.of<ConfiguracionesGeneralesService>(context,
                              listen: false);
                      final errorMessage =
                          await guardarDiasLaborales.actualizarMailSettings(
                        mailSettingsProvider.mailDriver,
                        mailSettingsProvider.mailHost,
                        mailSettingsProvider.mailPort,
                        mailSettingsProvider.mailUserName,
                        mailSettingsProvider.mailPassword,
                        mailSettingsProvider.mailEncryption,
                        mailSettingsProvider.mailFromAddress,
                        mailSettingsProvider.mailFromName,
                      );
                      if (context.mounted) {
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, '/configuracionGeneral');
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
                      mailSettingsProvider.isLoading = false;
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save),
                  const SizedBox(width: 20),
                  Text(mailSettingsProvider.isLoading ? 'Espere...' : 'Guardar')
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Form(
            key: mailSettingsProvider.formKeyTest,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  keyboardType: TextInputType.text,
                  controller: mailTestController,
                  decoration: InputDecorations.inputDecoration(
                    labelText: 'Destinatario',
                    hintText: 'Destinatario',
                    prefixIcon: Icons.alternate_email_rounded,
                  ),
                  onChanged: (value) => mailSettingsProvider.mailTest = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: mailSettingsProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      if (!mailSettingsProvider.isValidFormTest()) return;
                      mailSettingsProvider.isLoading = true;
                      /* print(mailSettingsProvider.dias.length.toString()); */
                      final mailSettings =
                          Provider.of<ConfiguracionesGeneralesService>(context,
                              listen: false);
                      final errorMessage = await mailSettings
                          .enviarCorreoPrueba(mailSettingsProvider.mailTest);
                      if (context.mounted) {
                        if (errorMessage == null) {
                          Flushbar(
                            backgroundColor: AppColors.successColor,
                            message: '¡Correo de prueba, enviado!',
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
                      mailSettingsProvider.isLoading = false;
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.send_rounded),
                  const SizedBox(width: 20),
                  Text(mailSettingsProvider.isLoading
                      ? 'Espere...'
                      : 'Enviar correo de prueba')
                ],
              ),
            ),
          ),
          const Text(
            '(Si el correo no se visualiza en la bandeja de entrada, puede revisar la carpeta de \'spam\')',
            style: TextStyle(fontSize: 10),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}
