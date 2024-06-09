import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todoonlineapp/Auth/auth_gate.dart';
import 'package:todoonlineapp/Auth/authentication.dart';
import 'package:todoonlineapp/Components/All_components.dart';

class LoginRoom extends StatelessWidget {
  final void Function()? tap;
  final authRoom = AuthUser();
  LoginRoom({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
    TextEditingController _emailController = TextEditingController();
    TextEditingController _pController = TextEditingController();
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 150,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20))),
                child: const Stack(
                  children: [
                    Center(
                        child: Text(
                      "ToDo App",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 28),
                    ))
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Text(
              "LOGIN",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                  fontSize: 35),
            ),
            SizedBox(
              height: 60,
            ),
            textFieldWidget(
              HintText: "Enter Email",
              Fieldicons: Icon(Icons.email),
              securetext: false,
              controller: _emailController,
            ),
            SizedBox(
              height: 60,
            ),
            textFieldWidget(
              HintText: "Enter Password",
              Fieldicons: Icon(Icons.lock),
              securetext: true,
              controller: _pController,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Forget Password!",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 14),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 50,
            ),
            Button(
              tap: () {
                authRoom.Login(_emailController.text, _pController.text)
                    .then((value) {
                  showProgressDialog(context, "Login Success");
                  AuthGate();
                  startTimer(context);
                }).onError((error, StackTrace) {
                  showProgressDialog(
                      context, "Something is Wrong!");
                  startTimer(context);
                });
              },
              ButtonText: "LOGIN",
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "New User!",
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 12),
                ),
                InkWell(
                    onTap: tap,
                    child: Text(
                      " Register Now",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> showProgressDialog(
      BuildContext context, String title) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("$title"),
          
          actions: [
          TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Ok"))
          ],
        );
      },
    );
  }

  void startTimer(BuildContext context) {
    Duration duration = Duration(seconds: 3);
    Timer timer = Timer(duration, () {
    Navigator.pop(context);

    });
  }
}
