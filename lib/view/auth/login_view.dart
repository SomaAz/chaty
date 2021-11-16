import 'package:chaty/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginView extends GetWidget {
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
                        "Login",
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                      SizedBox(height: 10),
                      CustomText(
                        "Login to continue to Chaty",
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      SizedBox(height: 60),
                      Form(
                        child: Column(
                          children: [
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
                          Text("Don't have an account?"),
                          TextButton(
                            child: Text(
                              "Sign up",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.blue[900],
                              ),
                            ),
                            onPressed: () {},
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
