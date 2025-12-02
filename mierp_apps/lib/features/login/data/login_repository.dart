import 'package:firebase_auth/firebase_auth.dart';

class LoginRepository {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> login(String email, String password) async {
    final res = await auth.signInWithEmailAndPassword(email: email, password: password);
    return res.user;
  }

  User? get currentUser => auth.currentUser;
}