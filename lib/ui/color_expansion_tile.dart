import 'package:cochinito_flutter/helpers/general_variables.dart';
import 'package:flutter/material.dart';

class ColorExpansionTile {
  static Color color({
    required int idStatus,
  }) {
    if (idStatus == 1) {
      return AppColors.pendienteColor;
    } else if (idStatus == 2) {
      return AppColors.habilitadoColor;
    } else if (idStatus == 3) {
      return AppColors.aprobadoColor;
    } else if (idStatus == 4) {
      return AppColors.rechazadoColor;
    } else if (idStatus == 5) {
      return AppColors.depositadoColor;
    } else if (idStatus == 6) {
      return AppColors.cobradoColor;
    } else {
      return AppColors.pendienteColor;
    }
  }
}
