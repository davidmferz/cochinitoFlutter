import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/empresa_model.dart';
import 'package:cochinito_flutter/services/empresa_service.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GestionEmpresasScreen extends StatefulWidget {
  const GestionEmpresasScreen({super.key});

  @override
  State<GestionEmpresasScreen> createState() => _GestionEmpresasScreenState();
}

class _GestionEmpresasScreenState extends State<GestionEmpresasScreen> {
  @override
  void initState() {
    super.initState();
    final empresaService = Provider.of<EmpresaService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
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
        title: const Text('Gestión de empresas'),
      ),
      body: HomeWorkArea(
        child: Column(
          children: [
            _BtnAddEmpresas(),
            const SizedBox(height: 16),
            Visibility(
              visible: Preferences.idRol == '1',
              child: Expanded(
                //CardContainer
                
                  child: _MostrarEmpresas(empresas: empresaService.getEmpresas()),
                
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BtnAddEmpresas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          children: [
            const SizedBox(height: 15),
            Visibility(
              visible: Preferences.idRol == '1',
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Preferences.idEmpresaConsultar = '';
                    Navigator.pushReplacementNamed(context, '/registroEmpresa');
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add_rounded),
                      SizedBox(width: 20),
                      Text('Registrar empresa')
                    ],
                  ),
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

class _MostrarEmpresas extends StatelessWidget {
  final Future<List<EmpresaModel>> empresas;

  const _MostrarEmpresas({
    required this.empresas,
  });

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
              return Card(
                child: ListTile(
                  title: Text(empresa.nombreEmpresa),
                  onTap: () {
                    Preferences.idEmpresaConsultar = empresa.id.toString();
                    debugPrint(empresa.id.toString());
                    Navigator.pushReplacementNamed(context, '/registroEmpresa');
                  },
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
