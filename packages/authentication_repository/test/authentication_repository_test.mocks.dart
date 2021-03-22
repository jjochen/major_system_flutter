// Mocks generated by Mockito 5.0.1 from annotations
// in authentication_repository/test/authentication_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i8;

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:firebase_auth_platform_interface/src/action_code_info.dart' as _i3;
import 'package:firebase_auth_platform_interface/src/action_code_settings.dart' as _i9;
import 'package:firebase_auth_platform_interface/src/auth_credential.dart' as _i11;
import 'package:firebase_auth_platform_interface/src/auth_provider.dart' as _i12;
import 'package:firebase_auth_platform_interface/src/id_token_result.dart' as _i7;
import 'package:firebase_auth_platform_interface/src/providers/phone_auth.dart' as _i15;
import 'package:firebase_auth_platform_interface/src/types.dart' as _i10;
import 'package:firebase_auth_platform_interface/src/user_info.dart' as _i14;
import 'package:firebase_auth_platform_interface/src/user_metadata.dart' as _i6;
import 'package:firebase_core/firebase_core.dart' as _i2;
import 'package:google_sign_in/google_sign_in.dart' as _i5;
import 'package:google_sign_in_platform_interface/src/types.dart' as _i13;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: comment_references
// ignore_for_file: unnecessary_parenthesis

class _FakeFirebaseApp extends _i1.Fake implements _i2.FirebaseApp {}

class _FakeActionCodeInfo extends _i1.Fake implements _i3.ActionCodeInfo {}

class _FakeUserCredential extends _i1.Fake implements _i4.UserCredential {}

class _FakeConfirmationResult extends _i1.Fake implements _i4.ConfirmationResult {}

class _FakeGoogleSignInAccount extends _i1.Fake implements _i5.GoogleSignInAccount {}

class _FakeGoogleSignInAuthentication extends _i1.Fake implements _i5.GoogleSignInAuthentication {}

class _FakeUserMetadata extends _i1.Fake implements _i6.UserMetadata {}

class _FakeIdTokenResult extends _i1.Fake implements _i7.IdTokenResult {}

class _FakeUser extends _i1.Fake implements _i4.User {}

/// A class which mocks [FirebaseAuth].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseAuth extends _i1.Mock implements _i4.FirebaseAuth {
  MockFirebaseAuth() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.FirebaseApp get app =>
      (super.noSuchMethod(Invocation.getter(#app), returnValue: _FakeFirebaseApp()) as _i2.FirebaseApp);
  @override
  set app(_i2.FirebaseApp? _app) => super.noSuchMethod(Invocation.setter(#app, _app), returnValueForMissingStub: null);
  @override
  Map<dynamic, dynamic> get pluginConstants =>
      (super.noSuchMethod(Invocation.getter(#pluginConstants), returnValue: <dynamic, dynamic>{})
          as Map<dynamic, dynamic>);
  @override
  _i8.Future<void> useEmulator(String? origin) => (super.noSuchMethod(Invocation.method(#useEmulator, [origin]),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> applyActionCode(String? code) => (super.noSuchMethod(Invocation.method(#applyActionCode, [code]),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<_i3.ActionCodeInfo> checkActionCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#checkActionCode, [code]), returnValue: Future.value(_FakeActionCodeInfo()))
          as _i8.Future<_i3.ActionCodeInfo>);
  @override
  _i8.Future<void> confirmPasswordReset({String? code, String? newPassword}) =>
      (super.noSuchMethod(Invocation.method(#confirmPasswordReset, [], {#code: code, #newPassword: newPassword}),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<_i4.UserCredential> createUserWithEmailAndPassword({String? email, String? password}) =>
      (super.noSuchMethod(Invocation.method(#createUserWithEmailAndPassword, [], {#email: email, #password: password}),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<List<String>> fetchSignInMethodsForEmail(String? email) => (super
          .noSuchMethod(Invocation.method(#fetchSignInMethodsForEmail, [email]), returnValue: Future.value(<String>[]))
      as _i8.Future<List<String>>);
  @override
  _i8.Future<_i4.UserCredential> getRedirectResult() =>
      (super.noSuchMethod(Invocation.method(#getRedirectResult, []), returnValue: Future.value(_FakeUserCredential()))
          as _i8.Future<_i4.UserCredential>);
  @override
  bool isSignInWithEmailLink(String? emailLink) =>
      (super.noSuchMethod(Invocation.method(#isSignInWithEmailLink, [emailLink]), returnValue: false) as bool);
  @override
  _i8.Stream<_i4.User?> authStateChanges() =>
      (super.noSuchMethod(Invocation.method(#authStateChanges, []), returnValue: Stream<_i4.User?>.empty())
          as _i8.Stream<_i4.User?>);
  @override
  _i8.Stream<_i4.User?> idTokenChanges() =>
      (super.noSuchMethod(Invocation.method(#idTokenChanges, []), returnValue: Stream<_i4.User?>.empty())
          as _i8.Stream<_i4.User?>);
  @override
  _i8.Stream<_i4.User?> userChanges() =>
      (super.noSuchMethod(Invocation.method(#userChanges, []), returnValue: Stream<_i4.User?>.empty())
          as _i8.Stream<_i4.User?>);
  @override
  _i8.Future<void> sendPasswordResetEmail({String? email, _i9.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendPasswordResetEmail, [], {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> sendSignInLinkToEmail({String? email, _i9.ActionCodeSettings? actionCodeSettings}) =>
      (super.noSuchMethod(
          Invocation.method(#sendSignInLinkToEmail, [], {#email: email, #actionCodeSettings: actionCodeSettings}),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> setLanguageCode(String? languageCode) =>
      (super.noSuchMethod(Invocation.method(#setLanguageCode, [languageCode]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> setSettings({bool? appVerificationDisabledForTesting, String? userAccessGroup}) =>
      (super.noSuchMethod(
          Invocation.method(#setSettings, [], {
            #appVerificationDisabledForTesting: appVerificationDisabledForTesting,
            #userAccessGroup: userAccessGroup
          }),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> setPersistence(_i10.Persistence? persistence) =>
      (super.noSuchMethod(Invocation.method(#setPersistence, [persistence]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<_i4.UserCredential> signInAnonymously() =>
      (super.noSuchMethod(Invocation.method(#signInAnonymously, []), returnValue: Future.value(_FakeUserCredential()))
          as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.UserCredential> signInWithCredential(_i11.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#signInWithCredential, [credential]),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.UserCredential> signInWithCustomToken(String? token) =>
      (super.noSuchMethod(Invocation.method(#signInWithCustomToken, [token]),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.UserCredential> signInWithEmailAndPassword({String? email, String? password}) =>
      (super.noSuchMethod(Invocation.method(#signInWithEmailAndPassword, [], {#email: email, #password: password}),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.UserCredential> signInWithEmailLink({String? email, String? emailLink}) =>
      (super.noSuchMethod(Invocation.method(#signInWithEmailLink, [], {#email: email, #emailLink: emailLink}),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.ConfirmationResult> signInWithPhoneNumber(String? phoneNumber, [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(Invocation.method(#signInWithPhoneNumber, [phoneNumber, verifier]),
          returnValue: Future.value(_FakeConfirmationResult())) as _i8.Future<_i4.ConfirmationResult>);
  @override
  _i8.Future<_i4.UserCredential> signInWithPopup(_i12.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithPopup, [provider]),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<void> signInWithRedirect(_i12.AuthProvider? provider) =>
      (super.noSuchMethod(Invocation.method(#signInWithRedirect, [provider]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> signOut() => (super.noSuchMethod(Invocation.method(#signOut, []),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<String> verifyPasswordResetCode(String? code) =>
      (super.noSuchMethod(Invocation.method(#verifyPasswordResetCode, [code]), returnValue: Future.value(''))
          as _i8.Future<String>);
  @override
  _i8.Future<void> verifyPhoneNumber(
          {String? phoneNumber,
          _i10.PhoneVerificationCompleted? verificationCompleted,
          _i10.PhoneVerificationFailed? verificationFailed,
          _i10.PhoneCodeSent? codeSent,
          _i10.PhoneCodeAutoRetrievalTimeout? codeAutoRetrievalTimeout,
          String? autoRetrievedSmsCodeForTesting,
          Duration? timeout = const Duration(seconds: 30),
          int? forceResendingToken}) =>
      (super.noSuchMethod(
          Invocation.method(#verifyPhoneNumber, [], {
            #phoneNumber: phoneNumber,
            #verificationCompleted: verificationCompleted,
            #verificationFailed: verificationFailed,
            #codeSent: codeSent,
            #codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
            #autoRetrievedSmsCodeForTesting: autoRetrievedSmsCodeForTesting,
            #timeout: timeout,
            #forceResendingToken: forceResendingToken
          }),
          returnValue: Future.value(null),
          returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  String toString() => (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '') as String);
}

/// A class which mocks [GoogleSignIn].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignIn extends _i1.Mock implements _i5.GoogleSignIn {
  MockGoogleSignIn() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i13.SignInOption get signInOption =>
      (super.noSuchMethod(Invocation.getter(#signInOption), returnValue: _i13.SignInOption.standard)
          as _i13.SignInOption);
  @override
  List<String> get scopes => (super.noSuchMethod(Invocation.getter(#scopes), returnValue: <String>[]) as List<String>);
  @override
  _i8.Stream<_i5.GoogleSignInAccount?> get onCurrentUserChanged => (super
          .noSuchMethod(Invocation.getter(#onCurrentUserChanged), returnValue: Stream<_i5.GoogleSignInAccount?>.empty())
      as _i8.Stream<_i5.GoogleSignInAccount?>);
  @override
  _i8.Future<_i5.GoogleSignInAccount?> signInSilently({bool? suppressErrors = true}) =>
      (super.noSuchMethod(Invocation.method(#signInSilently, [], {#suppressErrors: suppressErrors}),
          returnValue: Future.value(_FakeGoogleSignInAccount())) as _i8.Future<_i5.GoogleSignInAccount?>);
  @override
  _i8.Future<bool> isSignedIn() =>
      (super.noSuchMethod(Invocation.method(#isSignedIn, []), returnValue: Future.value(false)) as _i8.Future<bool>);
  @override
  _i8.Future<_i5.GoogleSignInAccount?> signIn() =>
      (super.noSuchMethod(Invocation.method(#signIn, []), returnValue: Future.value(_FakeGoogleSignInAccount()))
          as _i8.Future<_i5.GoogleSignInAccount?>);
  @override
  _i8.Future<_i5.GoogleSignInAccount?> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []), returnValue: Future.value(_FakeGoogleSignInAccount()))
          as _i8.Future<_i5.GoogleSignInAccount?>);
  @override
  _i8.Future<_i5.GoogleSignInAccount?> disconnect() =>
      (super.noSuchMethod(Invocation.method(#disconnect, []), returnValue: Future.value(_FakeGoogleSignInAccount()))
          as _i8.Future<_i5.GoogleSignInAccount?>);
  @override
  _i8.Future<bool> requestScopes(List<String>? scopes) =>
      (super.noSuchMethod(Invocation.method(#requestScopes, [scopes]), returnValue: Future.value(false))
          as _i8.Future<bool>);
}

/// A class which mocks [GoogleSignInAccount].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignInAccount extends _i1.Mock implements _i5.GoogleSignInAccount {
  MockGoogleSignInAccount() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get email => (super.noSuchMethod(Invocation.getter(#email), returnValue: '') as String);
  @override
  String get id => (super.noSuchMethod(Invocation.getter(#id), returnValue: '') as String);
  @override
  _i8.Future<_i5.GoogleSignInAuthentication> get authentication =>
      (super.noSuchMethod(Invocation.getter(#authentication),
          returnValue: Future.value(_FakeGoogleSignInAuthentication())) as _i8.Future<_i5.GoogleSignInAuthentication>);
  @override
  _i8.Future<Map<String, String>> get authHeaders =>
      (super.noSuchMethod(Invocation.getter(#authHeaders), returnValue: Future.value(<String, String>{}))
          as _i8.Future<Map<String, String>>);
  @override
  int get hashCode => (super.noSuchMethod(Invocation.getter(#hashCode), returnValue: 0) as int);
  @override
  _i8.Future<void> clearAuthCache() => (super.noSuchMethod(Invocation.method(#clearAuthCache, []),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  bool operator ==(dynamic other) => (super.noSuchMethod(Invocation.method(#==, [other]), returnValue: false) as bool);
  @override
  String toString() => (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '') as String);
}

/// A class which mocks [GoogleSignInAuthentication].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleSignInAuthentication extends _i1.Mock implements _i5.GoogleSignInAuthentication {
  MockGoogleSignInAuthentication() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String toString() => (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '') as String);
}

/// A class which mocks [User].
///
/// See the documentation for Mockito's code generation for more information.
class MockFirebaseUser extends _i1.Mock implements _i4.User {
  MockFirebaseUser() {
    _i1.throwOnMissingStub(this);
  }

  @override
  bool get emailVerified => (super.noSuchMethod(Invocation.getter(#emailVerified), returnValue: false) as bool);
  @override
  bool get isAnonymous => (super.noSuchMethod(Invocation.getter(#isAnonymous), returnValue: false) as bool);
  @override
  _i6.UserMetadata get metadata =>
      (super.noSuchMethod(Invocation.getter(#metadata), returnValue: _FakeUserMetadata()) as _i6.UserMetadata);
  @override
  List<_i14.UserInfo> get providerData =>
      (super.noSuchMethod(Invocation.getter(#providerData), returnValue: <_i14.UserInfo>[]) as List<_i14.UserInfo>);
  @override
  String get uid => (super.noSuchMethod(Invocation.getter(#uid), returnValue: '') as String);
  @override
  _i8.Future<void> delete() => (super.noSuchMethod(Invocation.method(#delete, []),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<String> getIdToken([bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdToken, [forceRefresh]), returnValue: Future.value(''))
          as _i8.Future<String>);
  @override
  _i8.Future<_i7.IdTokenResult> getIdTokenResult([bool? forceRefresh = false]) =>
      (super.noSuchMethod(Invocation.method(#getIdTokenResult, [forceRefresh]),
          returnValue: Future.value(_FakeIdTokenResult())) as _i8.Future<_i7.IdTokenResult>);
  @override
  _i8.Future<_i4.UserCredential> linkWithCredential(_i11.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#linkWithCredential, [credential]),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<_i4.ConfirmationResult> linkWithPhoneNumber(String? phoneNumber, [_i4.RecaptchaVerifier? verifier]) =>
      (super.noSuchMethod(Invocation.method(#linkWithPhoneNumber, [phoneNumber, verifier]),
          returnValue: Future.value(_FakeConfirmationResult())) as _i8.Future<_i4.ConfirmationResult>);
  @override
  _i8.Future<_i4.UserCredential> reauthenticateWithCredential(_i11.AuthCredential? credential) =>
      (super.noSuchMethod(Invocation.method(#reauthenticateWithCredential, [credential]),
          returnValue: Future.value(_FakeUserCredential())) as _i8.Future<_i4.UserCredential>);
  @override
  _i8.Future<void> reload() => (super.noSuchMethod(Invocation.method(#reload, []),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> sendEmailVerification([_i9.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(Invocation.method(#sendEmailVerification, [actionCodeSettings]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<_i4.User> unlink(String? providerId) =>
      (super.noSuchMethod(Invocation.method(#unlink, [providerId]), returnValue: Future.value(_FakeUser()))
          as _i8.Future<_i4.User>);
  @override
  _i8.Future<void> updateEmail(String? newEmail) => (super.noSuchMethod(Invocation.method(#updateEmail, [newEmail]),
      returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> updatePassword(String? newPassword) =>
      (super.noSuchMethod(Invocation.method(#updatePassword, [newPassword]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> updatePhoneNumber(_i15.PhoneAuthCredential? phoneCredential) =>
      (super.noSuchMethod(Invocation.method(#updatePhoneNumber, [phoneCredential]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> updateProfile({String? displayName, String? photoURL}) =>
      (super.noSuchMethod(Invocation.method(#updateProfile, [], {#displayName: displayName, #photoURL: photoURL}),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  _i8.Future<void> verifyBeforeUpdateEmail(String? newEmail, [_i9.ActionCodeSettings? actionCodeSettings]) =>
      (super.noSuchMethod(Invocation.method(#verifyBeforeUpdateEmail, [newEmail, actionCodeSettings]),
          returnValue: Future.value(null), returnValueForMissingStub: Future.value()) as _i8.Future<void>);
  @override
  String toString() => (super.noSuchMethod(Invocation.method(#toString, []), returnValue: '') as String);
}
