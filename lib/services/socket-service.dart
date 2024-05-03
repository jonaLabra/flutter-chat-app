import 'package:chat/global/enviroments.dart';
import 'package:chat/services/service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

// ignore: constant_identifier_names
enum ServerStatus { Online, Offline, Connecting }

class SocketService with ChangeNotifier {
  ServerStatus _serverStatus = ServerStatus.Connecting;
  IO.Socket? _socket;

  ServerStatus get serverStatus => _serverStatus;
  IO.Socket? get socket => _socket;

  Function get emit => _socket!.emit;

  void connect() async {
    final token = await AuthService.getToken();

    // Dart client
    _socket = IO.io(Enviroments.SOCKET_URL, {
      'transports': ['websocket'],
      'autoConnect': true,
      'forceNew': true,
      'extraHeaders': {'x-token': token}
    });

    socket!.onConnect((_) {
      _serverStatus = ServerStatus.Online;
      notifyListeners();
    });
    socket!.onDisconnect((_) {
      _serverStatus = ServerStatus.Offline;
      notifyListeners();
    });

    /* _socket!.on('nuevo-mensaje', (payload) {
      print('nuevo-mensaje $payload');
    });*/
  }

  void disconnect() {
    _socket!.disconnect();
  }
}
