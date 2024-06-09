import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todoonlineapp/Auth/authentication.dart';
import 'package:todoonlineapp/Components/All_components.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseDatabase.instance
        .ref("Users")
        .child("42lGqOR9WdgBn7KJkXUmAU4LpRo1");
    TextEditingController _PostController = TextEditingController();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.amber,
          onPressed: () {
            PostRoom(context);
          }),
      appBar: AppBar(
       automaticallyImplyLeading: false,
        elevation: 50.0,
        backgroundColor: Colors.amber,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.menu,
              size: 30,
              color: Colors.white,
            ),
          
           Row(children: [
              IconButton(onPressed: (){
              }, icon: const Icon(Icons.star,color: Colors.white,size: 30,)),
                const SizedBox(width: 10,),
             InkWell(
                onTap: () {
                  final Authuser = AuthUser();
                  Authuser.SignOut();
                },
                child: Icon(
                  Icons.logout,
                  size: 30,
                  color: Colors.white,
                ))
           ],)
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, bottom: 10),
                    child: Text(
                      "ToDos List",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                  )),
              StreamingData(),
              
              
            ],
          ),
        ),
      ),
    );
  }

  Future<void> PostRoom(BuildContext context) {
    TextEditingController _PostController = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Write Your Todo"),
            content: Container(
              width: double.maxFinite,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Todo Text: ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    textFieldWidget(
                      HintText: "Write there",
                      securetext: false,
                      controller: _PostController,
                      Fieldicons: Icon(Icons.text_fields_sharp),

                    ),
                    SizedBox(height: 8,),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            
                            Text("Todo Date: "), Text("1st June 2024")],
                        ),                   
                    
                  ],
                ),
              ),
            ),
            actions: [
              Button(ButtonText: "Add", tap: (){
Random random = new Random();
            final ref = FirebaseDatabase.instance.ref("Users").child("42lGqOR9WdgBn7KJkXUmAU4LpRo1");
                      int randomNumber = random.nextInt(100000 * 2);
                      ref.child(randomNumber.toString()).set({
                        'Todo': _PostController.text,
                        'Key': randomNumber.toString(),
                        'Date': "1st June",
                        'Important':false,
                      });
                      _PostController.clear();
                      Navigator.pop(context);
              })
            ],
          );
        });
  }
}
