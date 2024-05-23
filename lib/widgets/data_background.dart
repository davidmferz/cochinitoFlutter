import 'package:flutter/material.dart';

class DataBackground extends StatelessWidget {
  final Widget child;

  const DataBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //color: Colors.red,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          //para poner el fondo de color purpura
          const _ColorBox(),
          //para poner el icono de persona
          SafeArea(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
            ),
          ),
          //para poner el username y password
          child,
        ],
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      decoration: _purpleBackground(),
    );
  }

  BoxDecoration _purpleBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(89, 201, 167, 1),
            Color.fromRGBO(104, 202, 222, 1)
          ],
        ),
      );
}
