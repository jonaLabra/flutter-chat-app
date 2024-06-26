import 'package:chat/helpers/mostrar_alerta.dart';
import 'package:chat/services/service.dart';
import 'package:chat/widgets/button.dart';
import 'package:chat/widgets/custom_input.dart';
import 'package:chat/widgets/labels.dart';
import 'package:chat/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

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
                    title: 'Messenger',
                  ),
                  _Form(),
                  Labels(
                    title: '¿No tienes cuenta?',
                    subtitle: 'Crea una ahora!',
                    ruta: 'register',
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
  const _Form();

  @override
  State<_Form> createState() => _FormState();
}

class _FormState extends State<_Form> {
  final emailController = TextEditingController();
  final passowrdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var authService = Provider.of<AuthService>(context, listen: true);
    return Container(
      margin: const EdgeInsets.only(top: 40),
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
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
          Button(
              text: 'Ingresar',
              onPressed: authService.autenticando
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final loginOk = await authService.login(
                          emailController.text.trim(),
                          passowrdController.text.trim());

                      if (loginOk) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, 'users');
                      } else {
                        // ignore: use_build_context_synchronously
                        mostrarAlerta(context, 'Login incorrecto',
                            'Revisar credenciales');
                      }
                    })
        ],
      ),
    );
  }
}
