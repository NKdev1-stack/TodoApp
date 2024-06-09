import 'package:flutter/material.dart';
import 'package:todoonlineapp/Auth/authentication.dart';
import 'package:todoonlineapp/Components/All_components.dart';




class RegisterRoom extends StatelessWidget {
   final void Function()? tap;
  const RegisterRoom({super.key, required this.tap});

  @override
  Widget build(BuildContext context) {
     TextEditingController _emailController = TextEditingController();
  TextEditingController _pController = TextEditingController();
  TextEditingController _cpController = TextEditingController();
  
  bool clicked = false;

  final authentication = AuthUser();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
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
                "SIGNUP",
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
                height: 40,
              ),
              textFieldWidget(
                HintText: "Enter Password",
                Fieldicons: Icon(Icons.lock),
                securetext: true,
                controller: _pController,
              ),
              SizedBox(
                height: 40,
              ),
              textFieldWidget(
                HintText: "Confirm Password",
                Fieldicons: Icon(Icons.lock),
                securetext: false,
                controller: _cpController,
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
                height: 30,
              ),
            Button(
                tap: () {
                
                  authentication.SignUp(
                      _emailController.text, _pController.text).then((value){
                        showProgressDialog(context,"Creating Your Account!","Please Wait");
                      }).onError((error,StackTrace){
                             showProgressDialog(context,"Something is wrong","Try Again");
                      });
                      
                },
                ButtonText: "SIGNUP",
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account!",
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  InkWell(
                    onTap: tap,
                    child: Text(
                      " Login Now",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
  Future <void> showProgressDialog(BuildContext context,String title,String info){
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("$title"),
        content: ListTile(
          leading: CircularProgressIndicator(),
          title: Text("$info"),
        ),
      );
    },);
  }
}