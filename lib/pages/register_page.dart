import 'package:chat/widgets/button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffF2F2F2),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.9,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Logo(
                    title: 'Registro',
                  ),
                  _Form(),
                  Labels(
                    title: '¿Ya tienes una cuenta?',
                    subtitle: 'Ingresa ahora!',
                    ruta: 'login',
                  ),
                  Text(
                    'Terminos y condiciones',
                    style: TextStyle(fontWeight: FontWeight.w200),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();
  final nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CutsomInput(
            icon: Icons.perm_identity_outlined,
            placeHolder: 'Nombre',
            textEditingController: nameController,
            keyboardType: TextInputType.text,
            isPassword: false,
          ),
          CutsomInput(
            icon: Icons.email_outlined,
            placeHolder: 'Correo',
            textEditingController: emailController,
            keyboardType: TextInputType.emailAddress,
            isPassword: false,
          ),
          CutsomInput(
            icon: Icons.lock_outlined,
            placeHolder: 'Contraseña',
            textEditingController: passowrdController,
            keyboardType: TextInputType.text,
            isPassword: true,
          ),
          Button(text: 'Ingresar', onPressed: () {})
        ],
      ),
    );
  }
}
