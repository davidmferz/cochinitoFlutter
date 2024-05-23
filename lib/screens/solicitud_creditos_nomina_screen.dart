import 'package:cochinito_flutter/ui/color_expansion_tile.dart';
import 'package:intl/intl.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';

class SolicitudCreditosNominaScreen extends StatelessWidget {
  const SolicitudCreditosNominaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final creditosBService =
        Provider.of<CreditosNominaService>(context, listen: false);
    final usuarioService = Provider.of<UsersService>(context, listen: false);

    final tipoRol = Preferences.idRol;
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.payments_rounded),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, '/creditosNomina'),
          ),
          centerTitle: true,
          title: const Text('Solicitud de Créditos')),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => CreditosNominaProvider(),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _CreditosNomina(
                      creditosNomina:
                          creditosBService.getSolicitudCreditosNomina(),
                      usuario: usuarioService.getUser(),
                      status: creditosBService.getStatusCreditosNomina(),
                    ),
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

class _CreditosNomina extends StatelessWidget {
  final Future<List<CreditosNominaModel>> creditosNomina;
  final Future<ResponseUserModel?> usuario;
  final Future<List<StatusModel>> status;

  const _CreditosNomina({
    required this.creditosNomina,
    required this.usuario,
    required this.status,
  });
  @override
  Widget build(BuildContext context) {
    /* final diasFestivosProvider =
        Provider.of<DiasFestivosProvider>(context, listen: false); */
    var currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    final tipoRol = Preferences.idRol;
    return Flexible(
      child: Wrap(
        children: [
          Visibility(
            visible: tipoRol == '3',
            child: FutureBuilder(
              future: usuario,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.hasError.toString());
                }
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          solicitarCredito(context, snapshot.data!.nomina);
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_rounded),
                            SizedBox(width: 20),
                            Text('Solicitar crédito')
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
          const SizedBox(height: 15),
          FutureBuilder(
            future: creditosNomina,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              }
              if (snapshot.hasData) {
                // String porcentajeAcumuladoActual = '0';
                // String porcentajeAcumuladoActualDepositado = '0';
                // String nominaAcumuladoActual = '0';
                // String nominaAcumuladoActualDepositado = '0';
                String importeDisponible = '0';
                double saldoSolicitado = 0.0;
                double importeAPagar = 0.0; 
                importeDisponible = ((double.parse(
                                Preferences.porcentajeMaximo == ''
                                    ? '0'
                                    : Preferences.porcentajeMaximo) /
                            100) *
                        double.parse(Preferences.nominaTotal))
                    .toStringAsFixed(2);

                return Column(
                  children: [
                    Visibility(
                      visible: tipoRol == '3',
                      child: Table(
                        textBaseline: TextBaseline.ideographic,
                        border: TableBorder.all(color: AppColors.primaryColor),
                        columnWidths: {
                          0: FixedColumnWidth(
                              MediaQuery.of(context).size.width * 0.50),
                          1: FixedColumnWidth(
                              MediaQuery.of(context).size.width * 0.40),
                        },
                        children: [
                          TableRow(
                            children: [
                              const TableCell(
                                child: Text(
                                  'Nomina base:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  currencyFormat.format(
                                      double.parse(Preferences.nominaTotal)),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const TableCell(
                                child: Text(
                                  'Último fecha para solicitar:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  '${Preferences.ultimaFecha}',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const TableCell(
                                child: Text(
                                  '% de crédito disponible:',
                                  textAlign: TextAlign.center,
                                  style:
                                      TextStyle(color: AppColors.dangerColor),
                                ),
                              ),
                              TableCell(
                                child: Text(
                                  '${Preferences.porcentajeMaximo}%',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                      color: AppColors.dangerColor),
                                ),
                              ),
                            ],
                          ),
                          TableRow(
                            children: [
                              const TableCell(
                                child: Text(
                                  '\$ de crédito disponible:',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              TableCell(
                                child: Container(
                                  color: AppColors.successColor,
                                  child: Text(
                                    currencyFormat.format(
                                        double.parse(importeDisponible)),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length + 1,
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == snapshot.data!.length) {
                            double saldoDisponible =
                                double.parse(importeDisponible) -
                                    saldoSolicitado;
                            double costoServicio =
                                importeAPagar + (importeAPagar * 0.16);
                            double totalDescontarNomina = saldoSolicitado + costoServicio;
                            return Column(
                              children: [
                                Visibility(
                                  visible: snapshot.data!.isEmpty,
                                  child: const Center(
                                      child: Text('No hay datos que mostrar')),
                                ),
                                Table(
                                  textBaseline: TextBaseline.ideographic,
                                  border: TableBorder.all(
                                      color: AppColors.primaryColor),
                                  columnWidths: {
                                    0: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.50),
                                    1: FixedColumnWidth(
                                        MediaQuery.of(context).size.width *
                                            0.40),
                                  },
                                  children: [
                                    TableRow(
                                      children: [
                                        const TableCell(
                                          child: Text(
                                            'Saldo disponible:',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          child: Container(
                                            color: AppColors.successColor,
                                            child: Text(
                                              currencyFormat
                                                  .format(saldoDisponible),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const TableCell(
                                          child: Text(
                                            'Costo del servicio:',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            currencyFormat
                                                .format(costoServicio),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                    TableRow(
                                      children: [
                                        const TableCell(
                                          child: Text(
                                            'A descontar de la nomina:',
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        TableCell(
                                          child: Text(
                                            currencyFormat
                                                .format(totalDescontarNomina),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 40,
                                ),
                              ],
                            );
                          } else {
                            final solicitud = snapshot.data![index];
                            if (solicitud.statusId == 7) {
                              final creditosNominaProvider =
                                  Provider.of<CreditosNominaProvider>(context,
                                      listen: false);
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                creditosNominaProvider.puedeSolicitar = false;
                              });
                            }
                            saldoSolicitado = saldoSolicitado +
                                double.parse(solicitud.deduccionNomina);
                            importeAPagar = importeAPagar +
                                (double.parse(solicitud.deduccionNomina) *
                                    double.parse(
                                        solicitud.condicionPorcentaje) /
                                    100);
                            /* final DateTime docDateTime =
                                DateTime.parse(solicitud.updatedAt); */
                            /* final fechaModificacion =
                                DateFormat('yyyy-MM-dd').format(docDateTime); */
                            final fechaModificacion = solicitud.updatedAt;
                            final nombreUsuario =
                                '${solicitud.usuario.nombre} ${solicitud.usuario.apellidoPaterno} ${solicitud.usuario.apellidoMaterno}';
                            return Visibility(
                              visible: Preferences.idRol == '3',
                              child: Card(
                                child: ExpansionTile(
                                  //backgroundColor: ColorExpansionTile.color(idStatus: solicitud.status.id),
                                  collapsedBackgroundColor:
                                      ColorExpansionTile.color(
                                          idStatus: solicitud.status.id),
                                  initiallyExpanded: false,
                                  childrenPadding: const EdgeInsets.symmetric(
                                      horizontal: 15),
                                  expandedAlignment: Alignment.centerLeft,
                                  expandedCrossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  title: Text(
                                      '${nombreUsuario.toUpperCase()}\nSolicitud por: ${currencyFormat.format(double.parse(solicitud.deduccionNomina))}\nSolicitud del crédito: ${solicitud.fechaSolicitud}\nEstado: ${solicitud.status.nombreStatus}'),
                                  children: [
                                    Text(
                                        "Porcentaje solicitado: %${solicitud.porcentaje}"),
                                    Text(
                                        "Pago de la nomina: ${solicitud.fechaRealPagoNomina}"),
                                    Text(
                                        "Modificación del estado: $fechaModificacion"),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> solicitarCredito(
    BuildContext context,
    String? monto,
  ) {
    final creditosNominaProvider =
        Provider.of<CreditosNominaProvider>(context, listen: false);
    final TextEditingController anticipoController = TextEditingController();
    final TextEditingController calculoPorcentajeController =
        TextEditingController();
    /* final TextEditingController porcentajeController = TextEditingController();
    final TextEditingController calculoNominaController =
        TextEditingController(); */
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Solicitar crédito'),
          content: Form(
            key: creditosNominaProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: creditosNominaProvider.puedeSolicitar
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      /* TextFormField(
                        controller: porcentajeController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: 'Porcentaje',
                          prefixIcon: Icons.percent_rounded,
                        ),
                        onChanged: (value) {
                          if (value != '') {
                            final esPorcentaje = RegExp(
                                r'(^(100((\.)?(00)?)(\.0{1,2})?|[1-9]?\d(\.)?(\.\d{1,2})?)$)');
                            if (esPorcentaje.hasMatch(value)) {
                              creditosNominaProvider.porcentaje = value;
                              porcentajeController.text = value;
                              calculoNominaController.text =
                                  ((double.parse(value == '' ? '0' : value) / 100) *
                                          double.parse(monto!))
                                      .toString();
                            } else {
                              porcentajeController.text =
                                  creditosNominaProvider.porcentaje;
                            }
                          } else {
                            calculoNominaController.text = '';
                          }
                        },
                        validator: (value) {
                          return (value != null && value.isNotEmpty)
                              ? null
                              : 'Completa el campo';
                        },
                      ),
                      TextFormField(
                        controller: calculoNominaController,
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: 'Monto del crédito',
                          prefixIcon: Icons.payments_rounded,
                        ),
                        enabled: false,
                      ), */
                      TextFormField(
                        controller: anticipoController,
                        keyboardType: const TextInputType.numberWithOptions(
                            signed: false, decimal: true),
                        decoration: InputDecorations.inputDecoration(
                          hintText: 'Cantidad del anticipo',
                          labelText: 'Cantidad del anticipo',
                          prefixIcon: Icons.payments_rounded,
                        ),
                        onChanged: (value) {
                          if (value != '') {
                            /* final esCantidadValida = RegExp(
                          r'(^(100((\.))(\.0{1,2})?|[1-9]?\d(\.)?(\.\d{1,2})?)$)'); */
                            final esCantidadValida = RegExp(
                                r'(^([0-9]+((\.)?(00)?)(\.0{1,2})?|[1-9]?\d(\.)?(\.\d{1,2})?)$)');
                            if (esCantidadValida.hasMatch(value)) {
                              creditosNominaProvider.anticipo = value;
                              anticipoController.text = value;
                              calculoPorcentajeController.text =
                                  ((double.parse(value == '' ? '0' : value) *
                                              100) /
                                          double.parse(monto!))
                                      .toStringAsFixed(2);
                            } else {
                              anticipoController.text =
                                  creditosNominaProvider.anticipo;
                            }
                          } else {
                            calculoPorcentajeController.text = '';
                          }
                        },
                        validator: (value) {
                          return (value != null && value.isNotEmpty)
                              ? null
                              : 'Completa el campo';
                        },
                      ),
                      TextFormField(
                        controller: calculoPorcentajeController,
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: '',
                          prefixIcon: Icons.percent_rounded,
                        ),
                        enabled: false,
                      ),
                    ],
                  )
                : const Text(
                    'Tiene saldos pendientes.\nPor favor, comuniquese con el administrador de la empresa.',
                    textAlign: TextAlign.center,
                  ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: creditosNominaProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final creditoNomina = Provider.of<CreditosNominaService>(
                          context,
                          listen: false);
                      if (!creditosNominaProvider.isValidForm()) return;
                      creditosNominaProvider.isLoading = true;
                      String? errorMessage = await creditoNomina
                          .agregarCreditoNomina(anticipoController.text);
                      if (context.mounted) {
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, '/creditosNomina');
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
                      creditosNominaProvider.isLoading = false;
                    },
              child: const Text('Guardar'),
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
