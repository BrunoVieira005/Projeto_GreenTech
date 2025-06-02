import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotScreen extends StatefulWidget {
  final String? initialMessage;

  const ChatbotScreen({super.key, this.initialMessage});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> _messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    if (widget.initialMessage != null && widget.initialMessage!.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _sendMessage(widget.initialMessage!);
      });
    } else {
      _messages.add({
        'text': 'Olá! Como posso ajudar você hoje?',
        'isMe': false,
        'hasAvatar': true,
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage([String? message]) async {
    final userMessage = message ?? _controller.text.trim();

    if (userMessage.isEmpty) return;

    String url =
        "https://bruno-vieira-api-agro-langflow-mb-ads-v.hf.space/api/v1/run/7c29f82a-57fd-42cb-923b-d362ab899277";

    setState(() {
      _messages.add({'text': userMessage, 'isMe': true, 'hasAvatar': false});
      if (message == null) {
        _controller.clear();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "input_value": userMessage,
          "output_type": "chat",
          "input_type": "chat",
        }),
      );

      if (response.statusCode == 200) {
        final decoded = jsonDecode(utf8.decode(response.bodyBytes));
        final botReply =
            decoded["outputs"]?[0]?["outputs"]?[0]?["results"]?["message"]?["text"] ??
            "Não consegui entender";

        setState(() {
          _messages.add({'text': botReply, 'isMe': false, 'hasAvatar': true});
        });
      } else {
        setState(() {
          _messages.add({
            'text': 'Erro ao obter resposta do assistente',
            'isMe': false,
            'hasAvatar': true,
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({
          'text': 'Erro de conexão: $e',
          'isMe': false,
          'hasAvatar': true,
        });
      });
    } finally {
      WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
    }
  }

  void _limparMessages() {
    setState(() {
      _messages.clear();
      _messages.add({
        'text': 'Olá! Como posso ajudar você hoje?',
        'isMe': false,
        'hasAvatar': true,
      });
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF386641),
      body: Column(
        children: [
          Stack(
            children: [
              ClipPath(
                clipper: CorrectCurvedClipper(),
                child: Container(
                  height: 230,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 5,
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 45),
                    child: Image.asset('assets/images/logo.png', height: 170),
                  ),
                ),
              ),
              Positioned(
                top: 60,
                left: 10,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.grey[800],
                    size: 24,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final msg = _messages[index];
                  return MessageBubble(
                    text: msg['text'],
                    isMe: msg['isMe'],
                    hasAvatar: msg['hasAvatar'] ?? false,
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'Digite sua mensagem...',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 14,
                        ),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  // REVISED SEND BUTTON WITH INKWELL FOR TAP AND LONG PRESS
                  Container(
                    width: 50,
                    height: 50,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6A994E),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Material(
                      // Use Material to ensure InkWell's splash effect works
                      color:
                          Colors
                              .transparent, // Make it transparent so the Container's color shows through
                      child: InkWell(
                        onTap: _sendMessage, // Standard tap to send message
                        onLongPress:
                            _limparMessages, // Long press to clear messages
                        borderRadius: BorderRadius.circular(
                          25,
                        ), // Match the button's border radius
                        child: const Center(
                          // Center the icon visually
                          child: Icon(Icons.send, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// MESSAGE BUBBLE WIDGET
class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final bool hasAvatar;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    this.hasAvatar = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 10.0,
      ), // Increased vertical padding
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isMe && hasAvatar)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/broc.png',
                      width: 45,
                      height: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(15),
                      topRight: const Radius.circular(15),
                      bottomLeft: const Radius.circular(5),
                      bottomRight: const Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    text,
                    style: const TextStyle(color: Colors.black),
                  ),
                ),
              ],
            )
          else
            Flexible(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(15),
                    topRight: const Radius.circular(15),
                    bottomLeft:
                        isMe
                            ? const Radius.circular(15)
                            : const Radius.circular(5),
                    bottomRight:
                        isMe
                            ? const Radius.circular(5)
                            : const Radius.circular(15),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(text, style: const TextStyle(color: Colors.black)),
              ),
            ),
        ],
      ),
    );
  }
}

// CORRECT CURVED CLIPPER FROM HOMESCREEN
class CorrectCurvedClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height);
    path.lineTo(size.width * 0.6, size.height);
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width,
      size.height * 0.3,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
