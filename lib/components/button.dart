import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final Function onPressed;
  final Color color;
  final Color textColor;

  const Button({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color = Colors.blue,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        widget.onPressed();
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        minimumSize: const Size(double.infinity, 44),
        backgroundColor: widget.color,
        foregroundColor: widget.textColor,
        elevation: 0,
      ),
      child: Text(widget.text),
    );
  }
}
