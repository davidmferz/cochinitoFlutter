import 'package:cochinito_flutter/helpers/general_variables.dart';
import 'package:cochinito_flutter/helpers/preferences.dart';
import 'package:cochinito_flutter/services/users_service.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionUsuariosScreen extends StatefulWidget {
  const GestionUsuariosScreen({super.key});

  @override
  State<GestionUsuariosScreen> createState() => _GestionUsuariosScreenState();
}

class _GestionUsuariosScreenState extends State<GestionUsuariosScreen> {
  @override
  void initState() {
    super.initState();
    final usersService = Provider.of<UsersService>(context, listen: false);
    usersService.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    final usersService = Provider.of<UsersService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home_rounded,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Gestión de usuarios'),
      ),
      body: HomeWorkArea(
        child: Column(
          children: [
            _BtnAddUsuario(),
            const SizedBox(height: 16),
            Expanded(
              //CardContainer
              child: _MostrarUsuarios(usersService: usersService),
            ),
          ],
        ),
      ),
    );
  }
}

class _BtnAddUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Preferences.idUserConsultar = '';
                  Navigator.pushReplacementNamed(context, '/registroUsuario');
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.supervised_user_circle_sharp),
                    SizedBox(width: 20),
                    Text('Registrar usuario')
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 5),
      ],
    );
  }
}

class _MostrarUsuarios extends StatelessWidget {
  const _MostrarUsuarios({super.key, required this.usersService});

  final UsersService usersService;

  @override
  Widget build(BuildContext context) {
    return Consumer<UsersService>(
      builder: (context, usersService, child) {
        return ListView.builder(
          itemCount: usersService.users.length,
          itemBuilder: (context, index) {
            final u = usersService.users[index];
            if (Preferences.idRol == "1" ||
                (Preferences.idRol == "2" &&
                    u.empresaId.toString() == Preferences.idEmpresa)) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Preferences.idUserConsultar = u.id.toString();
                      debugPrint('u.id ${u.id}');
                      Navigator.pushReplacementNamed(
                          context, '/registroUsuario');
                    },
                    child: CardContainer(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          Text(
                            '${u.nombre} ${u.apellidoPaterno} ${u.apellidoMaterno}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(u.rol?.tipoRol ?? '-'),
                          const SizedBox(height: 5),
                          Text(
                            u.empresa?.nombreEmpresa ?? '',
                            style: const TextStyle(
                              color: Colors.purple,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 15),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ), // Agregar espacio entre cada CardContainer
                ],
              );
            } else {
              // Retornar un contenedor vacío si el rolId no es igual a 3
              return Container();
            }
          },
        );
      },
    );
  }
}
