import 'package:chaty/view/auth/login_view.dart';
import 'package:chaty/view/auth/sign_up_view.dart';
import 'package:chaty/view/home_view.dart';
import 'package:chaty/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlView extends GetWidget<AuthViewModel> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthViewModel>(builder: (control) {
      return Obx(() {
        if (control.user == null) {
          return control.page == "l" ? LoginView() : SignUpView();
        } else {
          return HomeView();
        }
      });
    });
  }
}
