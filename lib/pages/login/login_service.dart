import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginService{
  final FirebaseAuth auth = FirebaseAuth.instance;
  var db = FirebaseFirestore.instance;
  
  // sign in anon
  Future signInAnon() async {
    try {
      var result = await auth.signInAnonymously();
      User user = result.user;
      await db.collection("Users").doc(user.uid).set({
        "name" : "Anonymous",
        "dateCreated" : DateTime.now(),
      });
      
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<void> signOut() async{
    try {
      await auth.signOut();
    } catch (e) {
      return null;
    }
    
  }
}