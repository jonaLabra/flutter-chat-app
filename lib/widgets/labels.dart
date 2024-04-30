import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {super.key, required this.ruta, required this.title, this.subtitle});

  final String? ruta, title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title!,
          style: const TextStyle(
              color: Colors.black54, fontSize: 15, fontWeight: FontWeight.w300),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(context, ruta!),
          child: Text(
            subtitle!,
            style: TextStyle(
                color: Colors.blue[600],
                fontSize: 18,
                fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}
