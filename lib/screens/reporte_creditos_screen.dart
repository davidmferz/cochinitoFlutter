import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:cochinito_flutter/models/empresaReporte_model.dart';
import 'package:cochinito_flutter/models/empresa_model.dart';
import 'package:cochinito_flutter/services/empresa_service.dart';
import 'package:cochinito_flutter/services/reporteEmpresa_service.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ReporteCreditosScreen extends StatefulWidget {
  const ReporteCreditosScreen({super.key});

  @override
  State<ReporteCreditosScreen> createState() => _ReporteCreditosScreenState();
}

class _ReporteCreditosScreenState extends State<ReporteCreditosScreen> {
  var _granTotal = 0.0;
  @override
  void initState() {
    super.initState();
    final empresaReporteService =
        Provider.of<EmpresaReporteService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    var currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    final empresaReporteService =
        Provider.of<EmpresaReporteService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.home_rounded,
          ),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Reporte Creditos'),
      ),
      body: HomeWorkArea(
        child: Column(
          children: [
            const Text('A continuacion se muesta Lista de empresas que tienen por lo menos un credito en estatus depositado'),
            const SizedBox(height: 16),
            Expanded(
              //CardContainer
              child: _MostrarEmpresas(
                empresas: empresaReporteService.getReporteEmpresas(),
                onChange: (val) {
                  setState(() {
                    _granTotal = val;
                  });
                },
              ),
            ),

            Text('Gran total ${currencyFormat.format(double.parse(Preferences.totalGeneral))}'),
          ],
        ),
      ),
    );
  }
}

class _MostrarEmpresas extends StatelessWidget {
  final Future<List<EmpresaReporteModel>> empresas;
  final ValueChanged<double> onChange;
  const _MostrarEmpresas({
    required this.empresas,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    var currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return FutureBuilder<List<EmpresaReporteModel>>(
      future: empresas,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              EmpresaReporteModel empresa = snapshot.data![index];
              // Remover la coma antes de convertir a double
              String deduccionTotalString =
                  empresa.deduccionTotal.replaceAll(',', '');
              double deduccionTotal =
                  double.tryParse(deduccionTotalString) ?? 0.0;

              // Llamar a la función para actualizar el gran total
              //onDeduccionTotalChanged(deduccionTotal);
              return Card(
                child: ListTile(
                  title: Text(empresa.nombreEmpresa),
                  subtitle: Text(empresa.deduccionTotal),
                  onTap: () {
                    Preferences.idEmpresa = empresa.id.toString();
                    Navigator.pushReplacementNamed(context, '/consultaCredito');
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
