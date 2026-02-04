import 'package:evently_app/core/services/toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class FirebaseAuthUtils {
  static Future<bool> singUpWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      var firebaseAuthInstance = FirebaseAuth.instance;
      final credential = await firebaseAuthInstance
          .createUserWithEmailAndPassword(
            email: emailAddress,
            password: password,
          );
      await credential.user?.sendEmailVerification();

      ToastMessage.showSuccessMessage(
        "Verification email sent! Please check your inbox.",
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ToastMessage.showErrorMessage("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        ToastMessage.showErrorMessage(
          "The account already exists for that email.",
        );
      }
      return Future.value(false);
    } catch (e) {
      print(e);
      return Future.value(false);
    }
  }

  static Future<bool> singInWithEmailAndPassword(
    String emailAddress,
    String password,
  ) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return Future.value(true);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-credential') {
        ToastMessage.showErrorMessage("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        ToastMessage.showErrorMessage("Wrong password provided for that user.");
      }
      return Future.value(false);
    }
  }

  static Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<UserCredential?> signInWithGoogle() async {
    GoogleSignIn.instance.initialize(
      serverClientId: "526665649751-r7c7ci51oc0j2tt5i1el1ii1horffocj.apps.googleusercontent.com",
    );
    final GoogleSignInAccount? googleUser = await GoogleSignIn.instance.authenticate();
    if(googleUser == null){
      throw FirebaseAuthException(code: 'ERROR_ABORTED_BY_USER',message: 'sign in with google');
    }
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken);

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
