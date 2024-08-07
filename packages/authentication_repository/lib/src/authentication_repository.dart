import 'dart:async';

import 'package:authentication_repository/src/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';

/// Thrown if during the sign up process if a failure occurs.
class SignUpFailure implements Exception {}

/// Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class AuthenticationRepository {
  /// {@macro authentication_repository}
  const AuthenticationRepository({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  final firebase_auth.FirebaseAuth? _firebaseAuth;
  firebase_auth.FirebaseAuth _getFirebaseAuth() =>
      _firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
  final GoogleSignIn? _googleSignIn;
  GoogleSignIn _getGoogleSignIn() => _googleSignIn ?? GoogleSignIn.standard();

  /// Stream of [UserInfo] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [UserInfo.empty] if the user is not authenticated.
  Stream<UserInfo> get userInfo {
    return _getFirebaseAuth().authStateChanges().map((firebaseUser) {
      return firebaseUser == null ? UserInfo.empty : firebaseUser.toUserInfo;
    });
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpFailure] if an exception occurs.
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      await _getFirebaseAuth().createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception catch (_) {
      throw SignUpFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _getGoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _getFirebaseAuth().signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _getFirebaseAuth().signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [UserInfo.empty] from the [userInfo] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait([
        _getFirebaseAuth().signOut(),
        _getGoogleSignIn().signOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserInfo get toUserInfo {
    return UserInfo(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
