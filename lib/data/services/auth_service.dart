import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Get Current User
  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Email and Password Sign In
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(getErrorString(e.code));
    }
  }

  // Email and Password Sign Up
  Future<UserCredential> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw Exception(getErrorString(e.code));
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception(getErrorString(e.code));
    }
  }

  // Password Reset
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw Exception(getErrorString(e.code));
    }
  }

  // Error Handling
  // String getErrorString(String errorCode) {
  //   switch (errorCode) {
  //     case "invalid-email":
  //       return "Invalid email or password.";
  //     case "wrong-password":
  //       return "Invalid email or password.";
  //     case "user-not-found":
  //       return "User with this email doesn't exist.";
  //     case "user-disabled":
  //       return "User with this email has been disabled.";
  //     case "too-many-requests":
  //       return "Too many requests. Try again later.";
  //     case "operation-not-allowed":
  //       return "Signing in with Email and Password is not enabled.";
  //     case "email-already-in-use":
  //       return "An account already exists for this email.";
  //     case "weak-password":
  //       return "Password should be at least 6 characters.";
  //     default:
  //       return errorCode;
  //   }
  // }
  String getErrorString(String errorCode) {
    switch (errorCode) {
      case "invalid-email":
        return "Неверный адрес электронной почты или пароль.";
      case "wrong-password":
        return "Неверный адрес электронной почты или пароль.";
      case "user-not-found":
        return "Пользователь с таким адресом электронной почты не существует.";
      case "user-disabled":
        return "Пользователь с таким адресом электронной почты был отключен.";
      case "too-many-requests":
        return "Слишком много запросов. Попробуйте позже.";
      case "operation-not-allowed":
        return "Вход с помощью адреса электронной почты и пароля не включен.";
      case "email-already-in-use":
        return "Учетная запись с таким адресом электронной почты уже существует.";
      case "weak-password":
        return "Пароль должен содержать не менее 6 символов.";
      default:
        return errorCode;
    }
  }
}
