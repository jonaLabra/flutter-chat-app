import 'package:chat/services/service.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/usuario.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UsuariosPage extends StatefulWidget {
  const UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  final usuarios = [
    User(online: true, email: 'caro@gmail.com', nombre: 'Carito', uid: '1'),
    User(online: false, email: 'caro1@gmail.com', nombre: 'Carito1', uid: '2'),
    User(online: true, email: 'caro2@gmail.com', nombre: 'Carito2', uid: '3'),
  ];

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            authService.usuario!.nombre,
            style: const TextStyle(color: Colors.black),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, 'login');
                AuthService.deleteToken();
              },
              icon:
                  const Icon(Icons.exit_to_app_outlined, color: Colors.black)),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.blue[400],
              ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          header: WaterDropHeader(
              complete: Icon(
                Icons.check,
                color: Colors.blue[400],
              ),
              waterDropColor: Colors.blue[400]!),
          onRefresh: _cargarUsuarios,
          child: _listViewUsuarios(),
        ));
  }

  ListView _listViewUsuarios() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, index) => userListTile(usuarios[index]),
        separatorBuilder: (context, index) => const Divider(),
        itemCount: usuarios.length);
  }

  ListTile userListTile(User user) {
    return ListTile(
      title: Text(user.nombre),
      subtitle: Text(user.email),
      leading: CircleAvatar(
        backgroundColor: Colors.blue[100],
        child: Text(user.nombre.substring(0, 2)),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: user.online ? Colors.green : Colors.red),
      ),
    );
  }

  void _cargarUsuarios() async {
    // monitor network fetch
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
