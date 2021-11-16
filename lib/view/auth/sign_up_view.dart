import 'package:chaty/view/auth/login_view.dart';
import 'package:chaty/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpView extends GetWidget {
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
                        child: Column(
                          children: [
                            CustomText("Name",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "Type your full name",
                              ),
                            ),
                            SizedBox(height: 25),
                            CustomText("Email",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            TextFormField(
                              decoration: InputDecoration(
                                hintText: "email@example.com",
                              ),
                            ),
                            SizedBox(height: 25),
                            CustomText("Password",
                                fontSize: 18, fontWeight: FontWeight.w500),
                            TextFormField(
                              obscureText: true,
                              enableSuggestions: false,
                              autocorrect: false,
                              decoration: InputDecoration(
                                hintText: "●●●●●●●●",
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  onPressed: () {},
                                ),
                              ),
                            ),
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
                        onPressed: () {},
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
                              Get.offAll(() => LoginView());
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
