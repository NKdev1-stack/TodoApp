import 'package:flutter/material.dart';
import 'package:todoonlineapp/Pages/login.dart';
import 'package:todoonlineapp/Pages/register.dart';

class LoginOrRegister extends StatefulWidget {
   LoginOrRegister({super.key});


  @override
  State<LoginOrRegister> createState() => _LoginOrRegisterState();
}

class _LoginOrRegisterState extends State<LoginOrRegister> {
  bool showLoginpage = true;

 
  @override
  
  Widget build(BuildContext context) {
     if(showLoginpage){
        return LoginRoom(tap: Togglepages);
    }else{
      return RegisterRoom(tap: Togglepages);
    }
  }

   void Togglepages(){
    setState(() {
      showLoginpage = !showLoginpage;
    });
  }
}