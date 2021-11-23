import 'package:chaty/model/user_model.dart';
import 'package:chaty/service/firestore_service.dart';
import 'package:chaty/view/widgets/message_bubble.dart';
import 'package:chaty/view/widgets/message_field.dart';
import 'package:chaty/view_model/chat_view_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChatView extends GetWidget {
  final UserModel thisUserModel;
  final UserModel user;

  const ChatView(this.thisUserModel, this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          user.name,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 2,
        shadowColor: Colors.black,
      ),
      body: GetBuilder<ChatViewModel>(
        init: ChatViewModel(
          thisUserModel: thisUserModel,
          otherUserModel: user,
        ),
        builder: (ctr) {
          return FutureBuilder(
            future: ctr.returnChatRoom(),
            builder: (ctx, AsyncSnapshot snapshot) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Center(child: CircularProgressIndicator())
                  : StreamBuilder(
                      stream: FirestoreService()
                          .getChatRoomMessages(snapshot.data['chatRoomId']),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              streamSnapshot) {
                        if (streamSnapshot.connectionState ==
                                ConnectionState.waiting &&
                            !streamSnapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return LayoutBuilder(builder: (ctx, constraints) {
                            return SizedBox(
                              height: constraints.maxHeight,
                              child: Column(
                                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                // mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              "Chat started: ${DateFormat("yyyy-MM-dd").format((snapshot.data['timeCreated'] as Timestamp).toDate())}",
                                            ),
                                          ),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 0,
                                              vertical: 10,
                                            ),
                                            itemBuilder: (ctx, index) {
                                              return MessageBubble(
                                                sender: streamSnapshot.data!
                                                    .docs[index]['sender'],
                                                text: streamSnapshot
                                                    .data!.docs[index]['text'],
                                                image: streamSnapshot.data!
                                                                .docs[index]
                                                            ['sender'] ==
                                                        thisUserModel.uid
                                                    ? thisUserModel.image
                                                    : user.image,
                                                isThisUser: streamSnapshot
                                                            .data!.docs[index]
                                                        ['sender'] ==
                                                    thisUserModel.uid,
                                              );
                                            },
                                            itemCount: streamSnapshot
                                                .data!.docs.length,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  MessageField((val) {
                                    FirestoreService().sendMessage(
                                      sender: thisUserModel.uid,
                                      chatRoomId: snapshot.data['chatRoomId'],
                                      text: val,
                                    );
                                  }),
                                ],
                              ),
                            );
                          });
                        }
                      },
                    );
            },
          );
        },
      ),
    );
  }
}
