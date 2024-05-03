import 'package:chat/global/enviroments.dart';
import 'package:chat/models/mensjaes_response.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/services/service.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatService extends ChangeNotifier {
  User? usuarioTo;

  Future getChat(String usuarioId) async {
    final resp = await http
        .get(Uri.parse('${Enviroments.API_URL}/mensjaes/$usuarioId'), headers: {
      'Content-Type': 'application/json',
      'x-token': await AuthService.getToken()
    });

    final mensajesResponse = mensajesResponseFromJson(resp.body);
    return mensajesResponse.mensajes;
  }
}
