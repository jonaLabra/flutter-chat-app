// ignore_for_file: non_constant_identifier_names

class Enviroments {
  static String API_URL =
      'http://192.168.0.19:3000/api'; /* !Platform.isAndroid
      ? 'http://192.168.0.19:3000/api'
      : 'http://localhost:3000/api';*/

  static String SOCKET_URL = 'http://192.168.0.19:3000';
  // Platform.isAndroid ? 'http://192.168.0.19:3000' : 'http://localhost:3000';
}
