import 'package:chaty/model/user_model.dart';
import 'package:chaty/service/firestore_service.dart';
import 'package:chaty/view/chat_view.dart';
import 'package:chaty/view/widgets/app_drawer.dart';
import 'package:chaty/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PeopleView extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "People",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.8,
        shadowColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: FirestoreService().getAllUsers(),
                builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
                  return snapshot.connectionState == ConnectionState.waiting
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 4,
                            vertical: 12,
                          ),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            // crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          itemBuilder: (ctx, index) {
                            return _buildPersonCard(snapshot.data![index]);
                          },
                          itemCount: snapshot.data!.length,
                        );
                }),
          )
        ],
      ),
      drawer: AppDrawer(),
    );
  }

  Widget _buildPersonCard(UserModel user) {
    return GetBuilder<AuthViewModel>(builder: (ctr) {
      return Column(
        children: [
          InkWell(
            onTap: () async {
              //check if there is a chat room created between the two users
              //if there is a chat room created between them load it
              //if not create one then load it

              final thisUserData =
                  await FirestoreService().getUserData(ctr.user!.uid);

              final thisUserModel = UserModel(
                name: thisUserData['name'],
                uid: thisUserData['uid'],
                email: thisUserData['email'],
              );
              final bool sameUser = thisUserModel.uid == user.uid;
              var chatRooms = await FirestoreService().getChatRooms(
                sameUser ? [user] : [user, thisUserModel],
              );
              if (chatRooms.isEmpty) {
                print("Creating ChatRoom...");
                FirestoreService().createChatRoom([
                  user,
                  thisUserModel,
                ]);
                chatRooms = await FirestoreService().getChatRooms(
                  sameUser ? [user] : [user, thisUserModel],
                );
              }

              print(chatRooms.map((e) => e.data()));
              Get.to(() => ChatView(chatRooms.first.id));
            },
            borderRadius: BorderRadius.circular(60),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Container(
                color: Colors.grey[200],
                child: (user.image.isNotEmpty && user.image.isURL)
                    ? Image.network(
                        user.image,
                        errorBuilder: (context, error, stackTrace) {
                          print(error);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.person,
                              size: 80,
                              color: Colors.grey[400],
                            ),
                          );
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.person,
                          size: 80,
                          color: Colors.grey[400],
                        ),
                      ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ],
      );
    });
  }
}
