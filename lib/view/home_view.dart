import 'package:chaty/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GetBuilder<AuthViewModel>(builder: (controller) {
          return TextButton(
            child: Text("logout"),
            onPressed: () {
              controller.logout();
            },
          );
        }),
      ),
    );
  }
}
