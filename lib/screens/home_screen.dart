import 'package:cochinito_flutter/helpers/general_variables.dart';
import 'package:cochinito_flutter/helpers/preferences.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:flutter/material.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:provider/provider.dart';

class ParametrosNextScren {
  final String nextScreen;

  ParametrosNextScren({
    required this.nextScreen,
  });
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Preferences.nameRol),
        //leading: const SizedBox(),
        leading: const Image(
          image: AssetImage('assets/logo64.webp'),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await authService.logout();
              if (context.mounted) {
                Navigator.pushReplacementNamed(context, '/login');
              }
            },
            icon: const Icon(
              Icons.logout_rounded,
              color: AppColors.dangerColor,
            ),
          ),
        ],
      ),
      body: HomeWorkArea(
        child: _DataHome(),
      ),
    );
  }
}

class _DataHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 65),
          Text(
            Preferences.nombreUser,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
          ),
          Text(
            Preferences.nameEmpresa,
            style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
          ),
          const SizedBox(height: 30),
          //Gestion de usuarios
          Visibility(
            visible: Preferences.idRol == "1",
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/configuracionGeneral');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.settings),
                        SizedBox(width: 20),
                        Text('Configuraciones')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          Visibility(
            visible: Preferences.idRol == "1" || Preferences.idRol == "2",
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/gestionUsuarios');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.supervised_user_circle_sharp),
                        SizedBox(width: 20),
                        Text('Gestionar Usuarios')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Condiciones de credito
          
          Visibility(
            visible: Preferences.idRol == "1" || Preferences.idRol == "2",
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                        context,
                        '/condicionesCredito',
                        arguments: ParametrosNextScren(
                          nextScreen: '/registroCondicionesCredito',
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.edit),
                        SizedBox(width: 20),
                        Text('Condiciones Credito')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //consultar creditos
          
          Visibility(
            visible: Preferences.idRol == "1" || Preferences.idRol == "2",
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/reportesCredito');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.report),
                        SizedBox(width: 20),
                        Text('Reportes Creditos')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Gestionar empresas
          
          Visibility(
            visible: Preferences.idRol == "1",
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/gestionEmpresas');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.factory_rounded),
                        SizedBox(width: 20),
                        Text('Gestionar Empresas')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          /* const SizedBox(height: 15),
          //Gestionar Mi Cuenta
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.emoji_people_outlined),
                  SizedBox(width: 20),
                  Text('Gestionar Mi Cuenta')
                ],
              ),
            ),
          ), */
          //Calendario Bancario
          Visibility(
            visible: Preferences.idRol == "1" /* || Preferences.idRol == "2" */,
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/calendarioBancario');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.calendar_month_rounded),
                        SizedBox(width: 20),
                        Text('Calendario Bancario')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: Preferences.idRol == '2',
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/configuracionesEmpresa');
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.view_timeline_rounded),
                        SizedBox(width: 20),
                        Text('Periodos de Nómina')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            //visible: Preferences.idRol != '2',
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Preferences.idRol == '3'
                          ? Navigator.pushReplacementNamed(
                              context, '/creditosNomina')
                          : Navigator.pushReplacementNamed(
                              context,
                              '/condicionesCredito',
                              arguments: ParametrosNextScren(
                                nextScreen: '/creditosNomina',
                              ),
                            );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.payments_rounded),
                        const SizedBox(width: 20),
                        Preferences.idRol == '3'
                            ? const Text('Mis Créditos')
                            : const Text('Administrar Créditos')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
