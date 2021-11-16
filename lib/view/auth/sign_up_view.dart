import 'package:chaty/view/widgets/custom_text.dart';
import 'package:chaty/view_model/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetWidget<AuthViewModel> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 60),
                      CustomText(
                        "Sign up",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        "Sign up to join Chaty",
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      SizedBox(height: 60),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            CustomText("Name",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Type your full name",
                              ),
                              onSaved: (val) {
                                controller.name = val!.trim();
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Please fill this field";
                                }
                              },
                            ),
                            SizedBox(height: 25),
                            CustomText("Email",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "email@example.com",
                              ),
                              onSaved: (val) {
                                controller.email = val!.trim();
                              },
                              validator: (val) {
                                if (val == null) {
                                  return "Please fill this field";
                                }
                                if (!val.contains("@")) {
                                  return "Please type your email correctly";
                                }
                              },
                            ),
                            SizedBox(height: 25),
                            CustomText("Password",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            GetBuilder<AuthViewModel>(builder: (ctr) {
                              return TextFormField(
                                obscureText: !ctr.showPassword,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  hintText: "●●●●●●●●",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      ctr.showPassword
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                    ),
                                    onPressed: () {
                                      ctr.toggleShowPassword();
                                    },
                                  ),
                                ),
                                onSaved: (val) {
                                  controller.password = val!.trim();
                                },
                                validator: (val) {
                                  if (val == null) {
                                    return "Please fill this field";
                                  }
                                  if (val.length < 5) {
                                    return "Please make your password length 5-24 characters";
                                  }
                                },
                              );
                            }),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                  // SizedBox(height: 25),
                  Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          _formKey.currentState!.save();
                          if (_formKey.currentState!.validate()) {
                            controller.signup();
                          }
                        },
                        child: CustomText(
                          "Sign Up",
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15),
                          ),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.blue[900],
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Have an account?"),
                          TextButton(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            onPressed: () {
                              controller.togglePage();
                              print(controller.page);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
