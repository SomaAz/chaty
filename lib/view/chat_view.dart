import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends GetWidget {
  final dynamic chatRoom;

  const ChatView(this.chatRoom);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Osama",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.8,
        shadowColor: Colors.black,
      ),
    );
  }
}
