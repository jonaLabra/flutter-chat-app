// ignore_for_file: non_constant_identifier_names

import 'dart:io';

class Enviroments {
  static String API_URL = Platform.isAndroid
      ? 'http://192.168.0.19:3000/api'
      : 'http://localhost:3000/api';

  static String SOCKET_URL =
      Platform.isAndroid ? 'http://192.168.0.19:3000' : 'http://localhost:3000';
}
