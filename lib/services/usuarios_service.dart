import 'package:chat/global/enviroments.dart';
import 'package:chat/models/usuario.dart';
import 'package:chat/models/usuarios_response.dart';
import 'package:chat/services/service.dart';
import 'package:http/http.dart' as http;

class UsuariosService {
  Future<List<User>> getUsuarios() async {
    try {
      final resp = await http.get(Uri.parse('${Enviroments.API_URL}/usuarios'),
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          });
      final usuariosResponse = usuariosResponseFromJson(resp.body);
      return usuariosResponse.usuarios;
    } catch (e) {
      return [];
    }
  }
}
