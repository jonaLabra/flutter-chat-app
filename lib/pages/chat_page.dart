import 'dart:io';

import 'package:chat/pages/chaat_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _isWriting = false;

  final List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: Column(
            children: [
              CircleAvatar(
                backgroundColor: Colors.blue[100],
                maxRadius: 16,
                child: const Text(
                  'Ch',
                  style: TextStyle(fontSize: 12),
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Chocokrispis',
                style: TextStyle(color: Colors.black87, fontSize: 12),
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
        uid: '123',
        texto: text,
        animationController: AnimationController(
            vsync: this, duration: const Duration(milliseconds: 200)));
    _messages.insert(0, newMessage);
    newMessage.animationController!.forward();
    setState(() {
      _isWriting = false;
    });
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController!.dispose();
    }
    super.dispose();
  }
}
