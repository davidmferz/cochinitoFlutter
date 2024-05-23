import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/empresa_model.dart';
import 'package:cochinito_flutter/screens/screens.dart';
import 'package:cochinito_flutter/services/empresa_service.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ParametrosCondiciones {
  final String nombreEmpresa;
  final int idEmpresa;

  ParametrosCondiciones({
    required this.nombreEmpresa,
    required this.idEmpresa,
  });
}

class CondicionesCreditoScreen extends StatefulWidget {
  const CondicionesCreditoScreen({super.key});

  @override
  State<CondicionesCreditoScreen> createState() =>
      _CondicionesCreditoScreenState();
}

class _CondicionesCreditoScreenState extends State<CondicionesCreditoScreen> {
  @override
  void initState() {
    super.initState();
    final empresaService = Provider.of<EmpresaService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final parametros =
        ModalRoute.of(context)?.settings.arguments as ParametrosNextScren?;
    String nextScreen = "";
    if (parametros != null) {
      nextScreen = parametros.nextScreen;
    }
    final empresaService = Provider.of<EmpresaService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home_rounded,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Seleccione una empresa'),
      ),
      body: HomeWorkArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              //CardContainer
              child: _MostrarEmpresas(
                  empresas: empresaService.getEmpresas(),
                  nextScreen: nextScreen),
            ),
          ],
        ),
      ),
    );
  }
}
class _MostrarEmpresas extends StatelessWidget {
  final Future<List<EmpresaModel>> empresas;
  final String nextScreen;
  const _MostrarEmpresas({required this.empresas, required this.nextScreen});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<EmpresaModel>>(
      future: empresas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              EmpresaModel empresa = snapshot.data![index];
              return Visibility(
                visible: Preferences.idRol == '1' ||
                    (Preferences.idRol == "2" &&
                        empresa.id.toString() == Preferences.idEmpresa),
                child: Card(
                  child: ListTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(empresa.nombreEmpresa),
                        if (empresa.creditosCount > 0)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              '${empresa.creditosCount}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      Preferences.empresaSelect = empresa.id.toString();
                      Navigator.pushReplacementNamed(
                        context,
                        nextScreen,
                        arguments: ParametrosCondiciones(
                          nombreEmpresa: empresa.nombreEmpresa,
                          idEmpresa: empresa.id,
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
