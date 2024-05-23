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
import 'screens.dart';

class CreditosNominaScreen extends StatefulWidget {
  const CreditosNominaScreen({Key? key}) : super(key: key);

  @override
  _CreditosNominaScreenState createState() => _CreditosNominaScreenState();
}

class _CreditosNominaScreenState extends State<CreditosNominaScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool verTodosLosCreditos = false;
  List<int> estadosSeleccionados = [];
  @override
  void initState() {
    super.initState();
    // Agregar la ID del estado "Solicitado" por defecto
    estadosSeleccionados.add(1);
  }

  @override
  Widget build(BuildContext context) {
    final creditosBService =
        Provider.of<CreditosNominaService>(context, listen: false);
    final usuarioService = Provider.of<UsersService>(context, listen: false);
    final tipoRol = Preferences.idRol;

    return Scaffold(
      appBar: AppBar(
        leading: tipoRol == '3'
            ? IconButton(
                icon: const Icon(Icons.home_rounded),
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, '/home'),
              )
            : IconButton(
                icon: const Icon(Icons.arrow_back_rounded),
                onPressed: () => Navigator.pushReplacementNamed(
                  context,
                  '/condicionesCredito',
                  arguments: ParametrosNextScren(
                    nextScreen: '/creditosNomina',
                  ),
                ),
              ),
        centerTitle: true,
        title: tipoRol == '3'
            ? const Text('Mis Créditos')
            : const Text('Administrar Créditos'),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        color: Colors.white,
        backgroundColor: Colors.blue,
        onRefresh: () async {
          await Future<void>.delayed(const Duration(seconds: 3));
        },
        child: HomeWorkArea(
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
                      Row(
                        children: [
                          const Text('Ver todos los créditos'),
                          Checkbox(
                            value: verTodosLosCreditos,
                            onChanged: (value) {
                              setState(() {
                                verTodosLosCreditos = value!;
                              });
                            },
                          ),
                        ],
                      ),
                      ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    estadosSeleccionados.contains(1)
                                        ? estadosSeleccionados.remove(1)
                                        : estadosSeleccionados.add(1);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: estadosSeleccionados.contains(1)
                                        ? Colors.green
                                        : null),
                                child: const Text('Solicitado'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    estadosSeleccionados.contains(3)
                                        ? estadosSeleccionados.remove(3)
                                        : estadosSeleccionados.add(3);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: estadosSeleccionados.contains(3)
                                        ? Colors.green
                                        : null),
                                child: const Text('Aprobado'),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    estadosSeleccionados.contains(5)
                                        ? estadosSeleccionados.remove(5)
                                        : estadosSeleccionados.add(5);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: estadosSeleccionados.contains(5)
                                        ? Colors.green
                                        : null),
                                child: const Text('Depositado'),
                              ),
                              const SizedBox(width: 10),
                              
                            ],
                            
                          ),
                          Row(
                            children: [
                               ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    estadosSeleccionados.contains(6)
                                        ? estadosSeleccionados.remove(6)
                                        : estadosSeleccionados.add(6);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: estadosSeleccionados.contains(6)
                                        ? Colors.green
                                        : null),
                                child: const Text('Cobrado'),
                                
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    estadosSeleccionados.contains(2)
                                        ? estadosSeleccionados.remove(2)
                                        : estadosSeleccionados.add(2);
                                  });
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: estadosSeleccionados.contains(2)
                                        ? Colors.green
                                        : null),
                                child: const Text('Habilitado'),
                                
                              ),
                              const SizedBox(width: 10),
                            ],
                            
                          )
                        ],
                      ),
                      RefreshIndicator(
                        color: Colors.white,
                        backgroundColor: Colors.blue,
                        onRefresh: () async {
                          await _actualizarCreditos();
                        },
                        child: _CreditosNomina(
                          creditosNomina: creditosBService.getCreditosNomina(),
                          usuario: usuarioService.getUser(),
                          status: creditosBService.getStatusCreditosNomina(),
                          verTodosLosCreditos: verTodosLosCreditos,
                          estadosSeleccionados: estadosSeleccionados,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refreshIndicatorKey.currentState?.show();
          Navigator.pushReplacementNamed(context, '/creditosNomina');
        },
        child: const Icon(Icons.refresh_rounded),
      ),
    );
  }
}

Future<void> _actualizarCreditos() async {
  await Future<void>.delayed(const Duration(seconds: 3));
}

class _CreditosNomina extends StatelessWidget {
  final Future<List<CreditosNominaModel>> creditosNomina;
  final Future<ResponseUserModel?> usuario;
  final Future<List<StatusModel>> status;
  final bool verTodosLosCreditos;
  final List<int> estadosSeleccionados;

  const _CreditosNomina({
    required this.creditosNomina,
    required this.usuario,
    required this.status,
    required this.verTodosLosCreditos,
    required this.estadosSeleccionados,
  });

  @override
  Widget build(BuildContext context) {
    final tipoRol = Preferences.idRol;
    var currencyFormat = NumberFormat.currency(locale: 'es_MX', symbol: '\$');
    return RefreshIndicator(
      onRefresh: () async {
        await Future<void>.delayed(const Duration(seconds: 3));
      },
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
                          Navigator.pushReplacementNamed(
                              context, '/solicitudCreditosNomina');
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.credit_score_rounded),
                            SizedBox(width: 20),
                            Text('Solicitud de créditos')
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
                final List<CreditosNominaModel> creditos =
                    snapshot.data as List<CreditosNominaModel>;
                final List<CreditosNominaModel> creditosFiltrados =
                    verTodosLosCreditos
                        ? creditos
                        : creditos
                            .where((credito) => estadosSeleccionados
                                .contains(credito.status.id))
                            .toList();

                if (creditosFiltrados.isEmpty) {
                  return const Center(
                    child: Text("Sin información por el momento"),
                  );
                }
                return RefreshIndicator(
                  color: Colors.white,
                  backgroundColor: Colors.blue,
                  onRefresh: () {
                    return Future<void>.delayed(const Duration(seconds: 3));
                  },
                  child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: creditosFiltrados.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      final solicitud = creditosFiltrados[index];
                      final fechaModificacion = solicitud.updatedAt;
                      final nombreUsuario =
                          '${solicitud.usuario.nombre} ${solicitud.usuario.apellidoPaterno} ${solicitud.usuario.apellidoMaterno}';
                      return Visibility(
                        visible: Preferences.idRol == '3' ||
                            ((Preferences.idRol == "2" ||
                                    Preferences.idRol == "1") &&
                                solicitud.empresaId.toString() ==
                                    Preferences.empresaSelect),
                        child: Card(
                          child: ExpansionTile(
                            collapsedBackgroundColor: ColorExpansionTile.color(
                                idStatus: solicitud.status.id),
                            initiallyExpanded: false,
                            childrenPadding:
                                const EdgeInsets.symmetric(horizontal: 15),
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
                              Visibility(
                                visible: tipoRol == '1' ||
                                    (tipoRol == '2' &&
                                        solicitud.status.id == 1),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        editarCredito(context,
                                            creditosFiltrados[index], status);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.edit_rounded),
                                          SizedBox(width: 20),
                                          Text('Modificar estado del credito')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Visibility(
                                visible:
                                    tipoRol == '3' && solicitud.status.id == 1,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        eliminarCredito(context,
                                            creditosFiltrados[index], status);
                                      },
                                      child: const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.delete),
                                          SizedBox(width: 20),
                                          Text('Eliminar credito (cancelar)')
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
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

  Future<void> editarCredito(BuildContext context, CreditosNominaModel data,
      Future<List<StatusModel>>? status) {
    final creditosNominaProvider =
        Provider.of<CreditosNominaProvider>(context, listen: false);
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      creditosNominaProvider.status = data.status.id.toString();
    });
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modificar estado'),
          content: Form(
            key: creditosNominaProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FutureBuilder<List<StatusModel>>(
                  future: status,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DropdownButtonFormField(
                        isExpanded: true,
                        hint: const Text("Seleccione el estado"),
                        decoration: InputDecorations.inputDecoration(
                          hintText: '',
                          labelText: 'Tipo de estado',
                          prefixIcon: Icons.people_rounded,
                        ),
                        items: snapshot.data!.map((e) {
                          ///si se encuentra en estado depositado no se puede rechazar
                          bool isEnabled = true;
                          if (data.status.nombreStatus == "Solicitado") {
                            isEnabled = !(e.nombreStatus == "Depositado" ||
                                e.nombreStatus == "Cobrado" ||
                                e.nombreStatus == "Pendiente");
                          }

                          if (data.status.nombreStatus == "Habilitado") {
                            isEnabled = !(e.nombreStatus == "Solicitado" ||
                                e.nombreStatus == "Depositado" ||
                                e.nombreStatus == "Cobrado" ||
                                e.nombreStatus == "Pendiente");
                          }

                          if (data.status.nombreStatus == "Aprobado") {
                            isEnabled = !(e.nombreStatus == "Solicitado" ||
                                e.nombreStatus == "Habilitado" ||
                                e.nombreStatus == "Cobrado" ||
                                e.nombreStatus == "Pendiente");
                          }

                          if (data.status.nombreStatus == "Depositado") {
                            isEnabled = !(e.nombreStatus == "Rechazado" ||
                                e.nombreStatus == "Solicitado" ||
                                e.nombreStatus == "Habilitado" ||
                                e.nombreStatus == "Aprobado");
                          }

                          if (data.status.nombreStatus == "Pendiente") {
                            isEnabled = !(e.nombreStatus == "Rechazado" ||
                                e.nombreStatus == "Solicitado" ||
                                e.nombreStatus == "Habilitado" ||
                                e.nombreStatus == "Aprobado" ||
                                e.nombreStatus == "Depositado");
                          }

                          if (data.status.nombreStatus == "Rechazado") {
                            isEnabled = false;
                          }

                          if (data.status.nombreStatus == "Cobrado") {
                            isEnabled = !(e.nombreStatus == "Solicitado" ||
                                e.nombreStatus == "Habilitado" ||
                                e.nombreStatus == "Rechazado" ||
                                e.nombreStatus == "Aprobado" ||
                                e.nombreStatus == "Depositado");
                          }

                          return DropdownMenuItem(
                            value: e.id.toString(),
                            enabled: isEnabled,
                            child: Text(e.nombreStatus,
                                style: TextStyle(
                                  color: isEnabled
                                      ? Colors.black
                                      : Colors.grey.withOpacity(0.6),
                                )),
                          );
                        }).toList(),
                        onChanged: (value) {
                          creditosNominaProvider.status = value!;
                        },
                        value: data.status.id.toString(),
                        validator: (value) =>
                            value!.isEmpty ? 'Completa el campo' : null,
                      );
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    } else {
                      return const CircularProgressIndicator();
                    }
                  },
                ),
              ],
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
                      String? errorMessage =
                          await creditoNomina.modificarEstadoCredito(
                              data.id.toString(),
                              creditosNominaProvider.status);

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

  Future<void> eliminarCredito(BuildContext context,
      CreditosNominaModel credito, Future<List<StatusModel>>? status) async {
    final creditosNominaService =
        Provider.of<CreditosNominaService>(context, listen: false);

    bool confirmacion = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar solicitud de crédito'),
          content: const Text('¿Está seguro de eliminar este crédito?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirma la eliminación
              },
              child: const Text('Sí'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancela la eliminación
              },
              child: const Text('No'),
            ),
          ],
        );
      },
    );

    if (confirmacion) {
      try {
        // Realiza la eliminación del crédito
        await creditosNominaService.eliminarCredito(credito.id.toString());

        // Actualizar la interfaz o recargar los créditos
        Navigator.pushReplacementNamed(context, '/creditosNomina');
      } catch (error) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }
}
