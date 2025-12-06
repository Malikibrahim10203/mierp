import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class LoginRepository extends GetxController {
  final FirebaseAuth authFirebase = FirebaseAuth.instance;
  final FirebaseFirestore authStore = FirebaseFirestore.instance;

  RxString eCode = "".obs;

  Future<UserModel?> login(String email, String password) async {
    try {
      UserCredential userCredential = await authFirebase.signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      DocumentSnapshot snapDoc = await authStore.collection('users').doc(uid).get();
      if (!snapDoc.exists) {
        return null;
      }
      final data = snapDoc.data() as Map<String, dynamic>;
      UserModel userModel = UserModel.fromJson(data);
      return userModel;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        eCode.value = 'user-not-found';
      } else if (e.code == 'wrong-password') {
        eCode.value = 'wrong-password';
      } else if (e.code == 'invalid-email') {
        eCode.value = 'invalid-email';
      }
    } catch (e) {
      eCode.value = 'auth-error';
    }
    return null;
  }

  Future<UserModel?> loginWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

    try {
      await _googleSignIn.initialize(
        serverClientId: "868649407040-ad880bbhs9dv7d2k6sothd28735fq446.apps.googleusercontent.com"
      );
      await _googleSignIn.attemptLightweightAuthentication();
      final account = await _googleSignIn.authenticate();
      final auth = await account.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: auth.idToken,
      );
      final result = await authFirebase.signInWithCredential(credential);
      final uid = result.user!.uid;
      DocumentSnapshot snapDoc = await authStore.collection('users').doc(uid).get();
      final data = snapDoc.data() as Map<String,dynamic>;
      UserModel? userModel = UserModel.fromJson(data);
      return userModel;
    } catch(e) {
      print(e);
    }
  }

  User? get currentUser => authFirebase.currentUser;
}