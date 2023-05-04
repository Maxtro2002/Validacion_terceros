import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  static Future<Firebase?> firebaseInit() async {
    try {
      FirebaseApp app = await Firebase.initializeApp();
    } catch (e) {
      return null;
    }
  }

  static Future<UserCredential> signInWithGoogle() async {
    try {

      GoogleSignIn signIn = GoogleSignIn(scopes: ["email"]);

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await signIn.signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      throw Exception("Error en el login");
    }
  }
}
