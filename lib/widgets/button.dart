import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.text, required this.onPressed});

  final String? text;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
            textStyle: const MaterialStatePropertyAll<TextStyle>(
                TextStyle(color: Colors.white)),
            backgroundColor:
                MaterialStatePropertyAll<Color>(Colors.blue[600]!)),
        child: SizedBox(
          height: 55,
          width: double.infinity,
          child: Center(
            child: Text(
              text!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
          ),
        ));
  }
}
