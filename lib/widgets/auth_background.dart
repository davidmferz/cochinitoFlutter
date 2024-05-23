import 'package:flutter/material.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _BlueBox.colorBackground(),
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          const _BlueBox(),
          const _HeaderIcon(),
          child,
        ],
      ),
    );
  }
}

class _BlueBox extends StatelessWidget {
  const _BlueBox();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.40,
      decoration: colorBackground(),
    );
  }

  static BoxDecoration colorBackground() => const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(89, 201, 167, 1),
            Color.fromRGBO(104, 202, 222, 1)
          ],
        ),
      );
}

class _HeaderIcon extends StatelessWidget {
  const _HeaderIcon();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 20),
        child: Container(
          width:210, // Ancho deseado del contenedor
          height:210, // Alto deseado del contenedor
          decoration: const BoxDecoration(
            shape: BoxShape.circle, // Establece la forma como círculo
            image: DecorationImage(
              image: AssetImage('assets/logoAncho190.webp'),
              fit: BoxFit.contain, // Ajusta la imagen para cubrir el círculo
            ),
          ),
        ),
      ),
    );
  }
}

