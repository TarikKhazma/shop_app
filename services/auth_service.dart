import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // تسجيل الدخول
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Login Error: ${e.message}");
      return null;
    }
  }

  // إنشاء حساب جديد
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } on FirebaseAuthException catch (e) {
      print("Signup Error: ${e.message}");
      return null;
    }
  }

  // تسجيل الخروج
  Future<void> logout() async {
    await _auth.signOut();
  }

  // المستخدم الحالي
  User? get currentUser => _auth.currentUser;
}
