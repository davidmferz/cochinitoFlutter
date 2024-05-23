import 'package:cochinito_flutter/helpers/helpers.dart';
import 'package:flutter/material.dart';

class HomeWorkArea extends StatelessWidget {
  final Widget child;

  const HomeWorkArea({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        //color: Colors.red,
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            //para poner el fondo de color verde
            const _ColorBackground(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: child,
            )
          ],
        ),
      ),
    );
  }
}

class _ColorBackground extends StatelessWidget {
  const _ColorBackground();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container( 
      width: size.width,
      height: size.height,
      decoration: _colorDecoration(),
    );
  }

  BoxDecoration _colorDecoration() => const BoxDecoration(
    //color: Colors.red
    color: AppColors.whiteColor
  );
}
