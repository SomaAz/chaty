import 'package:chaty/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AccountView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          child: Text("logout"),
          onPressed: () {
            controller.logout();
          },
        ),
      ),
    );
  }
}
