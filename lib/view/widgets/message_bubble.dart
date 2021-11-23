import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageBubble extends GetWidget {
  final String sender;
  final String text;
  final String image;
  final bool isThisUser;
  const MessageBubble({
    required this.sender,
    required this.text,
    required this.image,
    required this.isThisUser,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment:
            isThisUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (!isThisUser)
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                width: Get.mediaQuery.size.width * .1,
                height: Get.mediaQuery.size.width * .1,
                color: Colors.grey[200],
                child: (image.isNotEmpty && image.isURL)
                    ? Image.network(
                        image,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              size: 1,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ),
          SizedBox(width: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isThisUser ? Get.theme.primaryColor : Colors.grey[200],
            ),
            child: Text(
              text,
              style: TextStyle(
                color: isThisUser ? Colors.white : null,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
