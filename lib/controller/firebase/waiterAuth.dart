import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class WaiterAuth {
  FirebaseAuth auth = FirebaseAuth.instance;
  signIn(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  signUp(String email, String password, name) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String uid = result.user!.uid;
      await FirebaseFirestore.instance
          .collection('waiters')
          .doc(uid)
          .set({'uid': uid, 'name': name, 'email': email});
    } on FirebaseAuthException catch (e) {
      e.toString();
    }
  }

  signOut() async {
    await auth.signOut();
  }
}
