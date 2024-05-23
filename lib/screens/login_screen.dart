import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:another_flushbar/flushbar.dart';

import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final preferences = Preferences();
    //Urls.initUrls(preferences.ip==''?'192.168.100.9/BLMovil/Residencial/trunk/src/App%20web/BLMResidencial/public':preferences.ip);
    return Scaffold(
      body: AuthBackground(
        /* child: AuthBackground( */
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 310,
              ),
              CardLoginForm(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Iniciar Sesión',
                      style: Theme.of(context).textTheme.titleLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        /* ), */
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm();

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);

    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecorations.authinputDecoration(
              hintText: 'ejemplo@ejemplo.com',
              labelText: 'Correo electrónico',
              prefixIcon: Icons.alternate_email,
            ),
            onChanged: (value) => loginForm.email = value,
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
          const SizedBox(
            height: 30,
          ),
          TextFormField(
            obscureText: true,
            autocorrect: false,
            keyboardType: TextInputType.text,
            decoration: InputDecorations.authinputDecoration(
              hintText: '*********',
              labelText: 'Contraseña',
              prefixIcon: Icons.lock_outline,
            ),
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.isNotEmpty)
                  ? null
                  : 'Completa el campo';
            },
          ),
          const SizedBox(
            height: 30,
          ),
          RawMaterialButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            fillColor:
                loginForm.isLoading ? Colors.black45 : AppColors.secondaryColor,
            padding: CustomButtonStyle.rawButtonPading(),
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService =
                        Provider.of<AuthService>(context, listen: false);
                    if (!loginForm.isValidForm()) return;
                    loginForm.isLoading = true;
                    final String? errorMessage = await authService.login(
                        loginForm.email, loginForm.password);
                    if (errorMessage == null) {
                      await authService.registerToken();
                      if (context.mounted) {
                        Flushbar(
                          backgroundColor: AppColors.successColor,
                          message: '¡Bienvenido!',
                          duration: const Duration(milliseconds: 2000),
                        ).show(context);
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    } else {
                      if (context.mounted) {
                        Flushbar(
                          backgroundColor: AppColors.dangerColor,
                          message: errorMessage,
                          duration: const Duration(milliseconds: 2000),
                        ).show(context);
                      }
                    }

                    loginForm.isLoading = false;
                  },
            child: CustomButtonStyle.rawButtonText(
              text: loginForm.isLoading ? 'Espere...' : 'Acceder',
            ),
          ),
          
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              _launchURL('https://cochinito.blmovil.com/forgot-password');
            },
            child: const Text('¿Olvidaste tu contraseña?'),
          ),

          /* const SizedBox(height: 15),
          TextButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/registro');
            },
            child: const Text('Registrarse'),
          ) */
        ],
      ),
    );
  }
}

_launchURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (await launcher.canLaunchUrl(uri)) {
    await launcher.launchUrl(uri, mode: launcher.LaunchMode.externalApplication);
  } else {
    throw 'No se pudo abrir el enlace $url';
  }
}
