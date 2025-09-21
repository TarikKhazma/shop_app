import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart'; // for kIsWeb

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// تسجيل مستخدم جديد
  Future<User?> signUp(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("Signup Success: ${userCredential.user?.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // طباعة تفاصيل الخطأ
      debugPrint("Signup FirebaseAuthException: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      debugPrint("Signup Unknown Error: $e");
      return null;
    }
  }

  /// تسجيل الدخول
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      debugPrint("Login Success: ${userCredential.user?.uid}");
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      debugPrint("Login FirebaseAuthException: ${e.code} - ${e.message}");
      return null;
    } catch (e) {
      debugPrint("Login Unknown Error: $e");
      return null;
    }
  }

  /// تسجيل الخروج
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      debugPrint("SignOut Success");
    } catch (e) {
      debugPrint("SignOut Error: $e");
    }
  }
}
