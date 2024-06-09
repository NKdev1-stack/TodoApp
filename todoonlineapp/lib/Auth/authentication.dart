
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todoonlineapp/Auth/auth_gate.dart';

class AuthUser{


final _auth = FirebaseAuth.instance;
final ref = FirebaseDatabase.instance.ref("Users");



  Future<UserCredential> SignUp(String Email, String Password)async{

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: Email, password: Password);

          ref.child(_auth.currentUser!.uid.toString()).set({
          "Todo": "This is Demo ToDo",
          'Date': "Current Date"
          });
        return userCredential;

    }on FirebaseException catch (e) {
     throw Exception(e);
    }
  }


Future<UserCredential> Login(String Email, String Password)async{
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(email: Email, 
    password: Password);
    return userCredential;
  } on FirebaseException catch (e) {
    throw Exception(e);
  }
}

Future SignOut(){
  return _auth.signOut();
}
}