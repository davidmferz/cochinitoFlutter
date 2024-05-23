import 'package:cochinito_flutter/helpers/general_variables.dart';
import 'package:cochinito_flutter/helpers/preferences.dart';
import 'package:cochinito_flutter/models/creditos_nomina_model.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/services/creditos_nomina_service.dart';
import 'package:cochinito_flutter/services/users_service.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ConsultaCreditos extends StatefulWidget {
  const ConsultaCreditos({super.key});

  @override
  State<ConsultaCreditos> createState() => _ConsultaCreditosScreenState();
}

class _ConsultaCreditosScreenState extends State<ConsultaCreditos> {
  @override
  void initState() {
    super.initState();
    final creditosService =
        Provider.of<CreditosNominaService>(context, listen: false);
    creditosService.getCreditosNomina();
  }

  @override
  Widget build(BuildContext context) {
    final creditosService = Provider.of<CreditosNominaService>(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.report,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/reportesCredito'),
        ),
        centerTitle: true,
        title: const Text('Reporte De Usuarios'),
      ),
      body: HomeWorkArea(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Expanded(
              //CardContainer
              child: _MostrarUsuarios(creditosService: creditosService),
            ),
          ],
        ),
      ),
    );
  }
}

class _MostrarUsuarios extends StatelessWidget {
  const _MostrarUsuarios({Key? key, required this.creditosService});

  final CreditosNominaService creditosService;

  @override
  Widget build(BuildContext context) {
    var currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');  
    return Consumer<CreditosNominaService>(
      builder: (context, creditosService, child) {
        return FutureBuilder<List<ReporteCreditosUsuariosModel>>(
          future:
              creditosService.getReporteCreditosUsuarios(Preferences.idEmpresa),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Text('No se encontraron creditos');
            } else {
              final List<ReporteCreditosUsuariosModel> credito = snapshot.data!;

              return ListView.builder(
                itemCount: credito.length,
                itemBuilder: (context, index) {
                  final c = credito[index];
                  String nombreUsuario = '${c.usuario.nombre} ${c.usuario.apellidoPaterno} ${c.usuario.apellidoMaterno}'.toUpperCase();
                  return Column(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: CardContainer(
                          child: Column(
                            children: [
                              const SizedBox(height: 15), 
                              Text(
                                nombreUsuario,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                'Total a deducir(con impuestos):',
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                currencyFormat.format(double.parse(c.deduccionTotal.replaceAll(",", ""))),
                                textAlign: TextAlign.center,
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
                      ),
                    ],
                  );
                },
              );
            }
          },
        );
      },
    );
  }
}
