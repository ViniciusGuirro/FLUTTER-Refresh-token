import 'package:flutter/material.dart';

class CustomBackgroundAuth extends StatefulWidget {
  final Widget child;
  final double height;

  const CustomBackgroundAuth(
      {super.key, required this.child, required this.height});

  @override
  State<CustomBackgroundAuth> createState() => _CustomBackgroundAuthState();
}

class _CustomBackgroundAuthState extends State<CustomBackgroundAuth> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        width: size.width / 1.2,
        height: size.height / widget.height,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(40),
          ),
          gradient: LinearGradient(
            stops: const [0.05, 0.5, 0.95],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.indigo,
              Colors.indigoAccent.shade100,
              Colors.indigo
            ],
          ),
        ),
        child: widget.child);
  }
}
