import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zoom_app_flutter/Utils/utils.dart';

class AuthMethod {
  Stream<User?> get authChange => _auth.authStateChanges();
  User get user => _auth.currentUser!;
  FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<bool> signInWithGoogle(context) async {
    bool result = false;
    // Trigger the authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      User? user = userCredential.user;
      if (user != null) {
        if (userCredential.additionalUserInfo!.isNewUser) {
          _firestore.collection("users").doc(user.uid).set({
            "username": user.displayName,
            "userId": user.uid,
            "userImage": user.photoURL,
          });
        }
        result = true;
      }
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
      result = false;
    }
    return result;
  }

  Future<void> saveMeeting(
    String roomId,
  ) async {
    await _firestore
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .collection("meeting")
        .doc(roomId)
        .set({
      "username": user.displayName,
      "userEmail": user.email,
      "userImage": user.photoURL,
      "startTime": Timestamp.now(),
    });
  }
}
