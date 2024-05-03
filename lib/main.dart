import 'package:chat/services/chat_service.dart';
import 'package:chat/services/socket-service.dart';
import 'package:chat/routes/routes.dart';
import 'package:chat/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthService()),
        ChangeNotifierProvider(create: (context) => SocketService()),
        ChangeNotifierProvider(create: (context) => ChatService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Chat Chocokrispis',
        initialRoute: 'loading',
        routes: app_routes,
      ),
    );
  }
}
