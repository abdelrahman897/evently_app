import 'package:evently_app/core/services/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthUtils{
  static void singUpWithEmailAndPassword(String emailAddress,String password)async{
    try {
      var firebaseAuthInstance = FirebaseAuth.instance;
      final credential = await firebaseAuthInstance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastMessage.showErrorMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        ToastMessage.showErrorMessage("The account already exists for that email.");
      }
    } catch (e) {
      print(e);
    }
  }
}