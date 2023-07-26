import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String label;
  final bool secret;
  final TextInputType type;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextField(
      {super.key,
      required this.icon,
      required this.label,
      this.validator,
      this.controller,
      this.secret = false,
      this.type = TextInputType.text});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool hidden = false;

  @override
  void initState() {
    super.initState();

    hidden = widget.secret;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.type,
        obscureText: hidden,
        cursorColor: Colors.white,
        decoration: InputDecoration(
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, // Define a cor da borda quando está em foco
              width: 2.0,
            ),
            borderRadius: BorderRadius.all(Radius.circular(35)),
          ),
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors
                    .white, // Define a cor da borda quando não estiver em foco
                width: 2.0, // Define a largura da borda aqui
              ),
              borderRadius: BorderRadius.all(Radius.circular(35))),
          suffixIcon: widget.secret
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      hidden = !hidden;
                    });
                  },
                  icon: Icon(hidden ? Icons.visibility : Icons.visibility_off,
                      color: Colors.white),
                )
              : null,
          prefixIcon: Icon(widget.icon, color: Colors.white),
          labelText: widget.label,
          labelStyle: const TextStyle(color: Colors.white),
          isDense: true,
          errorStyle: const TextStyle(
              color: Colors.white70, fontWeight: FontWeight.bold),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.indigo,
              width: 2.5,
            ),
            borderRadius: BorderRadius.circular(
              35,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.indigo,
            ),
            borderRadius: BorderRadius.circular(
              35,
            ),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white, // Define a cor da borda como branco
              width: 2.0, // Define a largura da borda aqui
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                35,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
