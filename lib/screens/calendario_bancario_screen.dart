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

class CalendarioBancarioScreen extends StatelessWidget {
  const CalendarioBancarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final calendarioBService =
        Provider.of<CalendarioBancarioService>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.home_rounded),
          onPressed: () => Navigator.pushReplacementNamed(context, '/home'),
        ),
        centerTitle: true,
        title: const Text('Calendario Bancario'),
      ),
      body: HomeWorkArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (_) => DiasLaboralesProvider(),
                  ),
                  ChangeNotifierProvider(
                    create: (_) => DiasFestivosProvider(),
                  ),
                ],
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _DataDiasLaborales(
                      calendarioDiasLaborales:
                          calendarioBService.getDiasLaborales(),
                    ),
                    const SizedBox(height: 15),
                    _DataDiasFestivos(
                      calendarioDiasFestivos:
                          calendarioBService.getDiasFestivos(),
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

class _DataDiasLaborales extends StatelessWidget {
  final Future<List<DiasLaboralesModel>> calendarioDiasLaborales;

  const _DataDiasLaborales({
    required this.calendarioDiasLaborales,
  });
  @override
  Widget build(BuildContext context) {
    final diasLaboralesProvider = Provider.of<DiasLaboralesProvider>(context);
    return Flexible(
      child: Wrap(
        children: [
          const Center(
            child: Text('Días laborales'),
          ),
          FutureBuilder(
            future: calendarioDiasLaborales,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              }
              if (snapshot.hasData) {
                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (BuildContext context, int index) {
                    /* var existValue = diasLaboralesProvider.dias
                              .firstWhere((element) =>
                                  element.id == snapshot.data![index].id,  orElse: () => snapshot.data![index]); */
                    return CheckboxListTile(
                      dense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 0.0,
                        vertical: 0.0,
                      ),
                      visualDensity: const VisualDensity(
                        horizontal: 0,
                        vertical: -4,
                      ),
                      onChanged: (value) {
                        String isChecked = '0';
                        if (value == true) {
                          isChecked = '1';
                        }

                        snapshot.data![index].status = isChecked;
                        var temp = [...diasLaboralesProvider.dias];
                        temp.removeWhere((element) =>
                            element.id == snapshot.data![index].id &&
                            element.status == isChecked);
                        temp.add(snapshot.data![index]);
                        diasLaboralesProvider.dias = temp;
                      },
                      value: diasLaboralesProvider.dias.isNotEmpty &&
                              diasLaboralesProvider.dias
                                      .firstWhere(
                                          (element) =>
                                              element.id ==
                                              snapshot.data![index].id,
                                          orElse: () => snapshot.data![index])
                                      .status ==
                                  '1'
                          ? true
                          : snapshot.data![index].status == '1',
                      title: Text(snapshot.data![index].diaSemana.toString()),
                    );
                  },
                );
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 15),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: diasLaboralesProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      diasLaboralesProvider.isLoading = true;
                      /* print(diasLaboralesProvider.dias.length.toString()); */
                      final guardarDiasLaborales =
                          Provider.of<CalendarioBancarioService>(context,
                              listen: false);
                      final errorMessage = await guardarDiasLaborales
                          .actualizarDiasLaborales(diasLaboralesProvider.dias);
                      if (context.mounted) {
                        if (errorMessage == null) {
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
                      diasLaboralesProvider.isLoading = false;
                    },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.save),
                  const SizedBox(width: 20),
                  Text(
                      diasLaboralesProvider.isLoading ? 'Espere...' : 'Guardar')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DataDiasFestivos extends StatelessWidget {
  final Future<List<DiasFestivosModel>> calendarioDiasFestivos;

  const _DataDiasFestivos({
    required this.calendarioDiasFestivos,
  });
  @override
  Widget build(BuildContext context) {
    final diasFestivosProvider =
        Provider.of<DiasFestivosProvider>(context, listen: false);
    return Flexible(
      child: Wrap(
        children: [
          const Center(
            child: Text('Días Festivos'),
          ),
          ElevatedButton(
            onPressed: () {
              agregarEditaFecha(context, DiasFestivosModel(id: 0, fecha: ''));
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_rounded),
                SizedBox(width: 20),
                Text('Nuevo registro')
              ],
            ),
          ),
          FutureBuilder(
            future: calendarioDiasFestivos,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.hasError.toString());
              }
              if (snapshot.hasData) {
                return ListView.builder(
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
                                onPressed: diasFestivosProvider.isLoading
                                    ? null
                                    : () async {
                                        FocusScope.of(context).unfocus();
                                        final calendarioBancario = Provider.of<
                                                CalendarioBancarioService>(
                                            context,
                                            listen: false);
                                        diasFestivosProvider.isLoading = true;
                                        final String? errorMessage =
                                            await calendarioBancario
                                                .eliminarDiaFestivo(
                                                    snapshot.data![index].id);
                                        if (context.mounted) {
                                          if (errorMessage == null) {
                                            Navigator.pushReplacementNamed(
                                                context, '/calendarioBancario');
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
                                        diasFestivosProvider.isLoading = false;
                                      },
                                icon: const Icon(
                                  Icons.delete_forever_rounded,
                                  color: AppColors.dangerColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  agregarEditaFecha(
                                      context, snapshot.data![index]);
                                },
                                icon: const Icon(
                                  Icons.edit_rounded,
                                  color: AppColors.secondaryColor,
                                ),
                              )
                            ],
                          ),
                        ),
                        title: Text(snapshot.data![index].fecha.toString()),
                      );
                    });
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }

  Future<void> agregarEditaFecha(BuildContext context, DiasFestivosModel data) {
    final diasFestivosProvider =
        Provider.of<DiasFestivosProvider>(context, listen: false);
    final TextEditingController fechaController =
        TextEditingController(text: data.fecha);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(data.id == 0 ? 'Agregar fecha' : 'Actualizar fecha'),
          content: Form(
            key: diasFestivosProvider.formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: fechaController,
                  decoration: InputDecorations.inputDecoration(
                    hintText: '',
                    labelText: 'Fecha',
                    prefixIcon: Icons.calendar_today_rounded,
                  ),
                  onTap: () async {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(DateTime.now().year + 2),
                    ).then((value) {
                      if (value != null) {
                        var dateTimeString = value.toString();
                        final dateTime = DateTime.parse(dateTimeString);

                        final format = DateFormat('yyyy-MM-dd');
                        final clockString = format.format(dateTime);
                        fechaController.text = clockString;
                      }
                    });
                  },
                  //onChanged: (value) => registerForm.nombre = value,
                  validator: (value) {
                    return (value != null && value.isNotEmpty)
                        ? null
                        : 'Completa el campo';
                  },
                )
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Guardar'),
              onPressed: diasFestivosProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final calendarioBancario =
                          Provider.of<CalendarioBancarioService>(context,
                              listen: false);
                      if (!diasFestivosProvider.isValidForm()) return;
                      diasFestivosProvider.isLoading = true;
                      String? errorMessage = '';
                      if (data.id == 0) {
                        errorMessage = await calendarioBancario
                            .agregarDiaFestivo(fechaController.text);
                      } else {
                        errorMessage =
                            await calendarioBancario.actualizarDiaFestivo(
                                data.id, fechaController.text);
                      }
                      if (context.mounted) {
                        if (errorMessage == null) {
                          Navigator.pushReplacementNamed(
                              context, '/calendarioBancario');
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
                      diasFestivosProvider.isLoading = false;
                    },
            ),
            TextButton(
                child: Text('Cancelar'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
          ],
        );
      },
    );
  }
}
