import 'dart:io';

import 'package:chat/models/mensjaes_response.dart';
import 'package:chat/pages/chat_message.dart';
import 'package:chat/services/chat_service.dart';
import 'package:chat/services/service.dart';
import 'package:chat/services/socket-service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  ChatService? chatService;
  SocketService? socketService;
  AuthService? authService;
  bool _isWriting = false;

  final List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authService = Provider.of<AuthService>(context, listen: false);

    socketService!.socket!.on('mensaje-personal', _listenMessage);

    _cargarHistorial(chatService!.usuarioTo!.uid);
  }

  void _cargarHistorial(String uid) async {
    List<Mensaje> chat = await chatService!.getChat(uid);
    final history = chat.map((e) => ChatMessage(
        texto: e.mensaje,
        uid: e.de,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 0))
          ..forward()));
    setState(() {
      _messages.insertAll(0, history);
    });
  }

  void _listenMessage(payload) {
    print('Mensaje $payload');
    ChatMessage message = ChatMessage(
        texto: payload['mensaje'],
        uid: payload['de'],
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));
    setState(() {
      _messages.insert(0, message);
    });

    message.animationController!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final usuarioPara = chatService!.usuarioTo;
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 16,
                child: Text(
                  usuarioPara!.nombre.substring(0, 2),
                  style: const TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 3),
              Text(
                usuarioPara.nombre,
                style: const TextStyle(color: Colors.black87, fontSize: 12),
              )
            ],
          ),
        ),
        body: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: _messages.length,
                    itemBuilder: (_, index) => _messages[index])),
            const Divider(
              height: 2,
            ),
            Container(
              color: Colors.white,
              child: _InputChat(),
            )
          ],
        ));
  }

  // ignore: non_constant_identifier_names
  Widget _InputChat() => SafeArea(
          child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          children: [
            Flexible(
                child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (txt) {
                setState(() {
                  if (txt.trim().isNotEmpty) {
                    _isWriting = true;
                  } else {
                    _isWriting = false;
                  }
                });
              },
              decoration:
                  const InputDecoration.collapsed(hintText: 'Enviar Mensaje'),
              focusNode: _focusNode,
            )),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              child: !Platform.isIOS
                  ? CupertinoButton(
                      onPressed: _isWriting
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                      child: const Text(
                        'Enviar',
                      ),
                    )
                  : Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.blue[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: _isWriting
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                            icon: const Icon(
                              Icons.send,
                            )),
                      ),
                    ),
            )
          ],
        ),
      ));

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    _focusNode.requestFocus();
    _textController.clear();
    final newMessage = ChatMessage(
        uid: authService!.usuario!.uid,
        texto: text,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));
    _messages.insert(0, newMessage);
    newMessage.animationController!.forward();
    setState(() {
      _isWriting = false;
    });

    socketService!.emit('mensaje-personal', {
      'de': authService!.usuario!.uid,
      'para': chatService!.usuarioTo!.uid,
      'mensaje': text
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController!.dispose();
    }
    socketService!.socket!.off('mensaje-personal');
    super.dispose();
  }
}
