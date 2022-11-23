import 'package:flutter/material.dart';

class Field extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const Field({
    Key? key,
    required this.label,
    required this.hint,
    required this.controller,
  }) : super(key: key);

  @override
  State<Field> createState() => _FieldState();
}

class _FieldState extends State<Field> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: widget.label,
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        hintText: widget.hint,
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
      ),
      controller: widget.controller,
    );
  }
}
