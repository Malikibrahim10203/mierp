import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mierp_apps/core/controller/loading_controller.dart';
import 'package:mierp_apps/core/models/user_model.dart';
import 'package:mierp_apps/features/login/presentation/login_view_model.dart';

class LoginRepository extends GetxController {
  final FirebaseAuth authFirebase = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore authStore = FirebaseFirestore.instance;

  final loadingC = Get.find<LoadingController>();

  RxString eCode = "".obs;
  RxBool hasError = false.obs;

  AuthCredential? _authCredential;
  String? _conflictEmail;

  Future<UserModel?> login(String email, String password) async {
    try {
      loadingC.showLoading();
      UserCredential userCredential = await authFirebase.signInWithEmailAndPassword(email: email, password: password);
      String uid = userCredential.user!.uid;
      DocumentSnapshot snapDoc = await authStore.collection('users').doc(uid).get();
      if (!snapDoc.exists) {
        return null;
      }
      final data = snapDoc.data() as Map<String, dynamic>;

      UserModel userModel = UserModel(
        uid: uid,
        email: data['email'],
        firstName: data['first_name'],
        lastName: data['last_name'],
        role: data['role'],
      );
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

  // Future<UserModel?> loginWithGoogle() async {
  //   try {
  //     await googleSignIn.initialize();
  //
  //     final GoogleSignInAccount? googleUser = await googleSignIn.authenticate(
  //       scopeHint: ['email'],
  //     );
  //
  //     if (googleUser == null) {
  //       print("Google Sign-In canceled");
  //       return null;
  //     }
  //
  //     final googleAuth = googleUser.authentication;
  //     final authClient = googleSignIn.authorizationClient;
  //     var authorization = await authClient.authorizationForScopes(['email']);
  //
  //     if (authorization == null) {
  //       authorization = await authClient.authorizeScopes(['email']);
  //     }
  //
  //     loadingC.showLoading();
  //
  //     if (authorization == null) {
  //       print("Authorization failed");
  //       return null;
  //     }
  //
  //     final credential = GoogleAuthProvider.credential(
  //       accessToken: authorization.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //
  //     try {
  //       final userCredential = await authFirebase.signInWithCredential(credential);
  //       final uid = userCredential.user!.uid;
  //
  //       DocumentSnapshot snapDoc =
  //       await authStore.collection('users').doc(uid).get();
  //
  //       final data = snapDoc.data() as Map<String, dynamic>;
  //       final userModel = UserModel.fromJson(data);
  //
  //       return userModel;
  //     } on FirebaseAuthException catch(e) {
  //       if (e.code == 'account-exists-with-different-credential') {
  //         print(e.code);
  //         return null;
  //       }
  //     } catch(e) {
  //       print("Error ini : $e");
  //     }
  //   } catch (e) {
  //     loadingC.hideLoading();
  //     print("Google login error: $e");
  //     return null;
  //   }
  // }

  Future<UserModel?> loginWithGoogle() async {
    try {
      await googleSignIn.initialize();

      final googleUser = await googleSignIn.authenticate(
        scopeHint: ['email']
      );

      if(googleUser==null) {
        print("Google Sign-In canceled");
        return null;
      };

      final googleAutorization = await googleUser.authentication;
      final idToken = googleAutorization.idToken;

      if(idToken==null) {
        eCode.value = "idtoken-missing";
        return null;
      };

      final googleCredential = GoogleAuthProvider.credential(
        idToken: idToken
      );
      final userCredential = await authFirebase.signInWithCredential(googleCredential);
      final uid = userCredential.user!.uid;
      final snapDoc = await authStore.collection('users').doc(uid).get();
      if(!snapDoc.exists) {
        eCode.value = "user-not-found-in-firestore";
        return null;
      };
      final docJson = snapDoc.data() as Map<String, dynamic>;
      print(authFirebase.currentUser!.providerData);
      return UserModel.fromJson(docJson);
    } catch(e) {
      print("Google Login Error: $e");
      return null;
    }
  }

  Future<void> linkToAnotherAccount() async {
    try {
      await googleSignIn.initialize();

      final googleUser = await googleSignIn.authenticate();

      if(googleUser.id.isEmpty){
        eCode.value = "authenticate-failed";
        return;
      }

      final googleAuth = googleUser.authentication;
      final idToken = googleAuth.idToken;

      if(idToken==null){
        eCode.value = "idtoken-missing";
        return;
      };

      final googleCredential = GoogleAuthProvider.credential(
        idToken: idToken
      );

      await authFirebase.currentUser!.linkWithCredential(googleCredential);
    } catch(e) {
      eCode.value = "error-link-google";
    }
  }


  User? get currentUser => authFirebase.currentUser;
}