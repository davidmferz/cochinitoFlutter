import 'package:another_flushbar/flushbar.dart';
import 'package:cochinito_flutter/models/models.dart';
import 'package:cochinito_flutter/providers/providers.dart';
import 'package:cochinito_flutter/services/services.dart';
import 'package:cochinito_flutter/ui/ui.dart';
import 'package:cochinito_flutter/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/helpers.dart';

class ConfiguracionEmpresaScreen extends StatelessWidget {
  const ConfiguracionEmpresaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final periodosPago =
        Provider.of<PeriodosPagoService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Periodos de Nómina'),
      ),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => PeriodosPagoProvider(),
              ),
            ],
            child: _PeriodosPago(
              periodosPago: periodosPago.getPeriodosPago(),
            ),
          ),
        ),
      ),
    );
  }
}

class _PeriodosPago extends StatelessWidget {
  final Future<List<PeriodosPagoModel>> periodosPago;

  const _PeriodosPago({
    required this.periodosPago,
  });
  @override
  Widget build(BuildContext context) {
    final periodosPagoProvider = Provider.of<PeriodosPagoProvider>(context);
    final nominasService = Provider.of<NominaService>(context);
    return Flex(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      direction: Axis.vertical,
      children: [
        /* const Center(
          child: Text('Periodos de pago'),
        ), */
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              await showDialog(
                context: context,
                builder: (c) {
                  return ChangeNotifierProvider(
                    create: (context) => PeriodosPagoProvider(),
                    child: _DialogCreaEditaPeriodo(
                      /* periodosPagoProvider:
                                              periodosPagoProvider, */
                      data: PeriodosPagoModel(id: 0, nominaId: 0, empresaId: 0),
                      nominas: nominasService.getTipoNominas(),
                    ),
                  );
                },
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded),
                SizedBox(width: 20),
                Text('Agregar periodo de pago')
              ],
            ),
          ),
        ),
        const SizedBox(height: 15),
        FutureBuilder(
          future: periodosPago,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text(snapshot.hasError.toString());
            }
            if (snapshot.hasData) {
              return Flexible(
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 0.0,
                      ),
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: -1,
                      ),
                      trailing: FittedBox(
                        fit: BoxFit.fill,
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: periodosPagoProvider.isLoading
                                  ? null
                                  : () async {
                                      FocusScope.of(context).unfocus();
                                      final periodoPago =
                                          Provider.of<PeriodosPagoService>(
                                              context,
                                              listen: false);
                                      periodosPagoProvider.isLoading = true;
                                      final String? errorMessage =
                                          await periodoPago.eliminarPeriodoPago(
                                              snapshot.data![index].id);
                                      if (context.mounted) {
                                        if (errorMessage == null) {
                                          Navigator.pushReplacementNamed(
                                              context, '/configuracionesEmpresa');
                                          Flushbar(
                                            backgroundColor:
                                                AppColors.successColor,
                                            message:
                                                'Registro eliminado correctamente',
                                            duration: const Duration(
                                                milliseconds: 2000),
                                          ).show(context);
                                        } else {
                                          Flushbar(
                                            backgroundColor:
                                                AppColors.dangerColor,
                                            message: errorMessage,
                                            duration: const Duration(
                                                milliseconds: 2000),
                                          ).show(context);
                                        }
                                      }
                                      periodosPagoProvider.isLoading = false;
                                    },
                              icon: const Icon(
                                Icons.delete_forever_rounded,
                                color: AppColors.dangerColor,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await showDialog(
                                  context: context,
                                  builder: (c) {
                                    return ChangeNotifierProvider(
                                      create: (context) =>
                                          PeriodosPagoProvider(),
                                      child: _DialogCreaEditaPeriodo(
                                        /* periodosPagoProvider:
                                              periodosPagoProvider, */
                                        data: snapshot.data![index],
                                        nominas:
                                            nominasService.getTipoNominas(),
                                      ),
                                    );
                                  },
                                );
                              },
                              icon: const Icon(
                                Icons.edit_rounded,
                                color: AppColors.secondaryColor,
                              ),
                            )
                          ],
                        ),
                      ),
                      title: textoPorPeriodoPago(snapshot, index),
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
    );
  }

  Widget textoPorPeriodoPago(
      AsyncSnapshot<List<PeriodosPagoModel>> snapshot, int index) {
    //nominaId = 1, semanal
    //nominaId = 2, catorcenal
    //nominaId = 3, quincenal
    //nominaId = 4, mensual
    var tipoPago = snapshot.data![index];
    var dias = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sabado',
      'Domingo'
    ];
    if (tipoPago.nominaId == 1) {
      return Text(
          'Periodo semanal:\nEl periodo de pago es el día ${dias[tipoPago.diaSemanal! - 1]} de cada semana.');
    } else if (tipoPago.nominaId == 2) {
      return Text(
          'Periodo catorcenal:\nEl periodo de pago son los días ${dias[tipoPago.diaCatorcena! - 1]} de las semanas ${tipoPago.tipoCatorcena}');
    } else if (tipoPago.nominaId == 3) {
      return Text(
          'Periodo quincenal:\nEl periodo de pago es el día ${tipoPago.primerDiaQuincena} y el ${tipoPago.segundoDiaQuincena} de cada mes');
    } else {
      //4
      return Text(
          'Periodo mensual:\nEl periodo de pago es el día ${tipoPago.diaMensual} de cada mes');
    }
  }
}

class _DialogCreaEditaPeriodo extends StatelessWidget {
  //final PeriodosPagoProvider periodosPagoProvider;
  final Future<List<TipoNominaModel>> nominas;
  final PeriodosPagoModel data;
  const _DialogCreaEditaPeriodo({
    //required this.periodosPagoProvider,
    required this.nominas,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final periodosPagoProvider = Provider.of<PeriodosPagoProvider>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (data.nominaId == 0) {
        periodosPagoProvider.setNominaId = periodosPagoProvider.getNominaId == 0
            ? (data.nominaId == 0 ? 1 : periodosPagoProvider.getNominaId)
            : periodosPagoProvider.getNominaId;
      } else {
        periodosPagoProvider.setNominaId = periodosPagoProvider.getNominaId == 0
            ? data.nominaId
            : periodosPagoProvider.getNominaId;
      }

      periodosPagoProvider.setDiaMensual =
          periodosPagoProvider.getDiaMensual == 0
              ? data.diaMensual ?? 1
              : periodosPagoProvider.getDiaMensual;
      periodosPagoProvider.setPrimerDiaQuincena =
          periodosPagoProvider.getPrimerDiaQuincena == 0
              ? data.primerDiaQuincena ?? 1
              : periodosPagoProvider.getPrimerDiaQuincena;
      periodosPagoProvider.setSegundoDiaQuincena =
          periodosPagoProvider.getSegundoDiaQuincena == 0
              ? data.segundoDiaQuincena ?? 1
              : periodosPagoProvider.getSegundoDiaQuincena;
      periodosPagoProvider.setDiaCatorcena =
          periodosPagoProvider.getDiaCatorcena == 0
              ? data.diaCatorcena ?? 1
              : periodosPagoProvider.getDiaCatorcena;
      periodosPagoProvider.setTipoCatorcena =
          periodosPagoProvider.getTipoCatorcena == ''
              ? data.tipoCatorcena ?? 'pares'
              : periodosPagoProvider.getTipoCatorcena;
      periodosPagoProvider.setDiaSemanal =
          periodosPagoProvider.getDiaSemanal == 0
              ? data.diaSemanal ?? 1
              : periodosPagoProvider.getDiaSemanal;
    });
    return AlertDialog(
      title: Text(data.id == 0 ? 'Agregar periodo' : 'Actualizar perido'),
      content: Form(
        key: periodosPagoProvider.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder<List<TipoNominaModel>>(
              future: nominas,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Tipo de nomina',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione tipo de nómina"),
                    items: snapshot.data!.map((e) {
                      return DropdownMenuItem(
                        value: e.id,
                        child: Text(e.tipoNomina),
                      );
                    }).toList(),
                    onChanged: (value) {
                      periodosPagoProvider.setNominaId = value!;
                    },
                    value: periodosPagoProvider.getNominaId,
                    validator: (value) {
                      return value == null ? 'Completa el campo' : null;
                    },
                    //value: registerForm.nominaId,
                  );
                } else if (snapshot.hasError) {
                  return Text("Error: ${snapshot.error}");
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
            periodosPagoProvider.getNominaId != 4
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Día de pago Mensual',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el día de pago mensual"),
                    items: generarListas(31),
                    onChanged: (value) {
                      periodosPagoProvider.setDiaMensual = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getDiaMensual,
                  ),
            periodosPagoProvider.getNominaId != 3
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Primer día de pago',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el día de pago"),
                    items: generarListas(31),
                    onChanged: (value) {
                      periodosPagoProvider.setPrimerDiaQuincena = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getPrimerDiaQuincena,
                  ),
            periodosPagoProvider.getNominaId != 3
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Segundo día de pago',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el día de pago"),
                    items: generarListas(31),
                    onChanged: (value) {
                      periodosPagoProvider.setSegundoDiaQuincena = value!;
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getSegundoDiaQuincena,
                  ),
            periodosPagoProvider.getNominaId != 2
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Dia de pago catorcenal',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el día de pago"),
                    items: [
                      'Lunes',
                      'Martes',
                      'Miércoles',
                      'Jueves',
                      'Viernes',
                      'Sabado',
                      'Domingo'
                    ].asMap().entries.map(
                      (day) {
                        return DropdownMenuItem<int>(
                          value: day.key + 1,
                          child: Text('${day.value}'),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      periodosPagoProvider.setDiaCatorcena = value as int;
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getDiaCatorcena,
                  ),
            periodosPagoProvider.getNominaId != 2
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Tipo de semana del pago',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el tipo de semana"),
                    items: ['pares', 'impares'].map(
                      (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          child: Text('Días $val'),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      periodosPagoProvider.setTipoCatorcena = value.toString();
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getTipoCatorcena,
                  ),
            periodosPagoProvider.getNominaId != 1
                ? const SizedBox()
                : DropdownButtonFormField(
                    decoration: InputDecorations.inputDecoration(
                      hintText: '',
                      labelText: 'Dia de pago semanal',
                      prefixIcon: Icons.calendar_view_day_rounded,
                    ),
                    isExpanded: true,
                    hint: const Text("Seleccione el día de pago"),
                    items: [
                      'Lunes',
                      'Martes',
                      'Miércoles',
                      'Jueves',
                      'Viernes',
                      'Sabado',
                      'Domingo'
                    ].asMap().entries.map(
                      (day) {
                        return DropdownMenuItem<int>(
                          value: day.key + 1,
                          child: Text('${day.value}'),
                        );
                      },
                    ).toList(),
                    onChanged: (value) {
                      periodosPagoProvider.setDiaSemanal = value as int;
                    },
                    validator: (value) =>
                        value == null ? 'Completa el campo' : null,
                    value: periodosPagoProvider.getDiaSemanal,
                  ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: periodosPagoProvider.isLoading
              ? null
              : () async {
                  FocusScope.of(context).unfocus();
                  final calendarioBancario =
                      Provider.of<PeriodosPagoService>(context, listen: false);
                  if (!periodosPagoProvider.isValidForm()) return;
                  periodosPagoProvider.isLoading = true;
                  String? errorMessage = '';
                  if (data.nominaId == 0) {
                    errorMessage = await calendarioBancario
                        .agregarPeriodoPago(periodosPagoProvider);
                  } else {
                    errorMessage = await calendarioBancario
                        .actualizarPeriodoPago(data.id, periodosPagoProvider);
                  }
                  if (context.mounted) {
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(
                          context, '/configuracionesEmpresa');
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
                  periodosPagoProvider.isLoading = false;
                },
          child: const Text('Guardar'),
        ),
        TextButton(
            child: Text('Cancelar'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }

  List<DropdownMenuItem<int>> generarListas(int rango) {
    return List<int>.generate(rango, (int index) => index + 1).map(
      (val) {
        return DropdownMenuItem<int>(
          value: val,
          child: Text('Día $val'),
        );
      },
    ).toList();
  }
}
