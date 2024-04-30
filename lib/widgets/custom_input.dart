import 'package:flutter/material.dart';

class CutsomInput extends StatelessWidget {
  const CutsomInput(
      {super.key,
      required this.icon,
      required this.placeHolder,
      required this.textEditingController,
      this.keyboardType,
      this.isPassword});

  final IconData? icon;
  final String? placeHolder;
  final TextEditingController? textEditingController;
  final TextInputType? keyboardType;
  final bool? isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: const Offset(0, 5),
                blurRadius: 5)
          ]),
      child: TextField(
        controller: textEditingController,
        autocorrect: false,
        keyboardType: keyboardType,
        obscureText: isPassword!,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: placeHolder),
      ),
    );
  }
}
