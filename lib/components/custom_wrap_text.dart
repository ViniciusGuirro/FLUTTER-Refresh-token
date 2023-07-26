import 'package:flutter/material.dart';

class CustomWrapText extends StatefulWidget {
  final String title;
  final String value;
  final String widgetType;
  final double fontSize;

  const CustomWrapText(
      {super.key,
      required this.title,
      required this.value,
      required this.widgetType,
      this.fontSize = 18});

  @override
  State<CustomWrapText> createState() => _CustomWrapTextState();
}

class _CustomWrapTextState extends State<CustomWrapText> {
  @override
  Widget build(BuildContext context) {
    return widget.widgetType == 'wrap'
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Wrap(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.value,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          )
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                Text(
                  widget.value,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.w700,
                    color: Colors.indigo,
                  ),
                ),
              ],
            ),
          );
  }
}
