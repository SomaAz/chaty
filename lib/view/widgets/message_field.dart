import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageField extends StatefulWidget {
  final void Function(String text) onPressed;

  const MessageField(this.onPressed);

  @override
  State<MessageField> createState() => _MessageFieldState();
}

class _MessageFieldState extends State<MessageField> {
  final TextEditingController _controller = TextEditingController();
  late final void Function(String text) _onPressed;
  @override
  void initState() {
    super.initState();
    _onPressed = widget.onPressed;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      color: Colors.orange.withOpacity(0),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    onPressed: _controller.text.isEmpty
                        ? null
                        : () {
                            _onPressed(_controller.text);
                            setState(() {
                              _controller.text = "";
                            });
                          },
                    icon: Icon(Icons.send),
                    color: Get.theme.primaryColor,
                  ),
                  hintText: "Type a message",
                  contentPadding: const EdgeInsets.all(12),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
