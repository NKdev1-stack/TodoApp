
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';


// TextField

class textFieldWidget extends StatelessWidget {
  final String HintText;
  final Icon? Fieldicons;
  final TextEditingController controller;
  final bool securetext;
  const textFieldWidget({
    super.key,
    required this.HintText,
    this.Fieldicons,
    required this.securetext,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: const BoxDecoration(color: Colors.white70),
      child: TextField(
        controller: controller,
        obscureText: securetext,
        decoration: InputDecoration(
          hintText: "$HintText",
          contentPadding: const EdgeInsets.only(left: 6, top: 10),
          prefixIcon: Fieldicons,
          suffixIcon: securetext
              ? Icon(Icons.visibility)
              : Icon(
                  Icons.visibility,
                  color: Colors.white70,
                ),
        ),
      ),
    );
  }
}

// Button

class Button extends StatelessWidget {
  final String ButtonText;
  final void Function()? tap;

  const Button({super.key, required this.ButtonText, required this.tap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: tap,
      child: Container(
        height: 50,
        width: 180,
        decoration: BoxDecoration(
            color: Colors.blue, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Text(
          "$ButtonText",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        )),
      ),
    );
  }
}

class StreamingData extends StatefulWidget {
  const StreamingData({super.key});

  @override
  State<StreamingData> createState() => _StreamingDataState();
}

class _StreamingDataState extends State<StreamingData> {
  final ref = FirebaseDatabase.instance
      .ref("Users")
      .child("42lGqOR9WdgBn7KJkXUmAU4LpRo1");
  TextEditingController _editController = TextEditingController();
  var importantTodo;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FirebaseAnimatedList(
       
        
        query: ref,
        itemBuilder: (context, snapshot, animation, index) {
          importantTodo = snapshot.child('Important').value;
          print(importantTodo);
          return Card(
            child: Container(
              height: 70,
              child: Center(
                  child: ListTile(
                  
                      leading: InkWell(
                          onTap: () {
                            showdialog(
                                context,
                                snapshot.child('Todo').value.toString(),
                                snapshot.child('Key').value.toString());
                          },
                          child: const Icon(Icons.edit)),
                      shape: RoundedRectangleBorder(),
                      tileColor: Colors.white10,
                      title: Text(snapshot.child('Todo').value.toString()),
                      subtitle: Text(snapshot.child("Date").value.toString()),
                      trailing: Wrap(
                        children: [
                          importantTodo
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      ref
                                          .child(snapshot
                                              .child("Key")
                                              .value
                                              .toString())
                                          .update({
                                        "Important": false,
                                      });
                                      importantTodo = false;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  "Mark as Not Important")));
                                    });
                                  },
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      ref
                                          .child(snapshot
                                              .child("Key")
                                              .value
                                              .toString())
                                          .update({"Important": true});
                                      importantTodo = true;
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text("Mark as Important")));
                                    });
                                  },
                                  child: Icon(
                                    Icons.star_border_outlined,
                                    color: Colors.amber,
                                  ),
                                ),
                          InkWell(
                            onTap: () {
                              ref
                                  .child(snapshot.child('Key').value.toString())
                                  .remove();
                            },
                            child: Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ))),
            ),
          );
        },
      ),
    );
  }

  Future<void> showdialog(BuildContext context, String title, String iD) async {
    _editController.text = title;
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Edit ToDo"),
            content: Container(
              child: TextField(
                controller: _editController,
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Close")),
              TextButton(
                  onPressed: () {
                    ref
                        .child(iD)
                        .update({"Todo": _editController.text}).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Todo Updated")));
                      Navigator.pop(context);
                    }).onError((error, StackTrace) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(error.toString())));
                    });
                  },
                  child: Text("Edit"))
            ],
          );
        });
  }
}





// Flexible(
//       child: FirebaseAnimatedList(
//         query: ref,
//         itemBuilder: (context, snapshot, animation, index) {
//          return ListTile(
//           title: Text(snapshot.value.toString()),
//           subtitle: Text("29 April"),

//          );
          
            
//         },),
//     );;


/******* Fetch Data In list Using Stream Builder */
// class StreamingData extends StatelessWidget {
//     final ref = FirebaseDatabase.instance.ref("Users").child("4321");
//     TextEditingController _editController = TextEditingController();
//    StreamingData({super.key});

//   @override
//   Widget build(BuildContext context) {
    
//     return Expanded(child:StreamBuilder(
//       stream: ref.onValue,
//       builder: (context,AsyncSnapshot <DatabaseEvent> snapshot){

//        if(!snapshot.hasData){
//           return CircularProgressIndicator();
//         }else{
//                   Map <dynamic,dynamic> map = snapshot.data!.snapshot.value as dynamic;
// List<dynamic> list = [];
// list.clear;
// list = map.values.toList();

//           return ListView.builder(

//           itemCount: snapshot.data!.snapshot.children.length,
//           itemBuilder: (context, index) {
            
//           return Card(
//             child:  Container(
//               height: 70,
//               child: Center(
//                 child: ListTile(
//                   leading: InkWell(
//                     onTap: (){showdialog(context,list[index]);},
//                     child: const Icon(Icons.edit)),
//                   shape: RoundedRectangleBorder(),
//                   tileColor: Colors.white10,
                  
//                   title: Text(list[index]['Todo'].toString()),
//                   trailing: InkWell(
//                     onTap: (){},
//                     child: Icon(Icons.delete,color: Colors.red,)),
                  
                  
//                  ),
//               ),
//             ),
//           );
//         },);
//         }
//       }
      
//       ));
      
//   }
// Future<void> showdialog(BuildContext context, String title)async{
//   _editController.text = title;
//   return showDialog(
//     context: context,
//     builder: (BuildContext context){
//       return AlertDialog(
//         title: Text("Edit ToDo"),
//         content: Container(child: TextField(controller: _editController,),),
//         actions: [

//           TextButton(onPressed: (){Navigator.pop(context);}, child: Text("Close")),
//           TextButton(onPressed: (){}, child: Text("Edit"))

//         ],
//       );
//     });
// }
// }
