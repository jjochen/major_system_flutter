import 'package:firebase_core_platform_interface/firebase_core_platform_interface.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'authentication_repository_test.mocks.dart';

const _mockFirebaseUserUid = 'mock-uid';
const _mockFirebaseUserEmail = 'mock-email';

class _FakeUserCredential extends Fake implements firebase_auth.UserCredential {
}

@GenerateMocks([
  firebase_auth.FirebaseAuth,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
], customMocks: [
  MockSpec<firebase_auth.User>(as: #MockFirebaseUser),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelFirebase.channel.setMockMethodCallHandler((call) async {
    if (call.method == 'Firebase#initializeCore') {
      return [
        {
          'name': defaultFirebaseAppName,
          'options': {
            'apiKey': '123',
            'appId': '123',
            'messagingSenderId': '123',
            'projectId': '123',
          },
          'pluginConstants': const <String, String>{},
        }
      ];
    }

    if (call.method == 'Firebase#initializeApp') {
      return <String, dynamic>{
        'name': call.arguments['appName'],
        'options': call.arguments['options'],
        'pluginConstants': const <String, String>{},
      };
    }

    return null;
  });

  TestWidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();

  const email = 'test@major_system.com';
  const password = 't0ps3cret42';
  const user = User(
    id: _mockFirebaseUserUid,
    email: _mockFirebaseUserEmail,
    name: null,
    photo: null,
  );

  group('AuthenticationRepository', () {
    // variables need initial value (null safety)
    var mockFirebaseAuth = MockFirebaseAuth();
    var mockGoogleSignIn = MockGoogleSignIn();
    var authenticationRepository = AuthenticationRepository(
      firebaseAuth: mockFirebaseAuth,
      googleSignIn: mockGoogleSignIn,
    );

    setUp(() {
      mockFirebaseAuth = MockFirebaseAuth();
      mockGoogleSignIn = MockGoogleSignIn();
      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
        googleSignIn: mockGoogleSignIn,
      );
    });

    test('creates FirebaseAuth instance internally when not injected', () {
      expect(() => AuthenticationRepository(), isNot(throwsException));
    });

    group('signUp', () {
      setUp(() {
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => _FakeUserCredential());
      });

      test('calls createUserWithEmailAndPassword', () async {
        await authenticationRepository.signUp(email: email, password: password);
        verify(mockFirebaseAuth.createUserWithEmailAndPassword(
                email: email, password: password))
            .called(1);
      });

      test('succeeds when createUserWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.signUp(email: email, password: password),
          completes,
        );
      });

      test('throws SignUpFailure when createUserWithEmailAndPassword throws',
          () async {
        when(mockFirebaseAuth.createUserWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(Exception());
        expect(
          authenticationRepository.signUp(email: email, password: password),
          throwsA(isA<SignUpFailure>()),
        );
      });
    });

    group('loginWithGoogle', () {
      const accessToken = 'access-token';
      const idToken = 'id-token';
      setUp(() {
        final googleSignInAuthentication = MockGoogleSignInAuthentication();
        final googleSignInAccount = MockGoogleSignInAccount();
        when(googleSignInAuthentication.accessToken).thenReturn(accessToken);
        when(googleSignInAuthentication.idToken).thenReturn(idToken);
        when(
          googleSignInAccount.authentication,
        ).thenAnswer((_) async => googleSignInAuthentication);
        when(
          mockGoogleSignIn.signIn(),
        ).thenAnswer((_) async => googleSignInAccount);
        when(mockFirebaseAuth.signInWithCredential(any))
            .thenAnswer((_) async => _FakeUserCredential());
      });

      test('calls signIn authentication, and signInWithCredential', () async {
        await authenticationRepository.logInWithGoogle();
        verify(mockGoogleSignIn.signIn()).called(1);
        verify(mockFirebaseAuth.signInWithCredential(any)).called(1);
      });

      test('succeeds when signIn succeeds', () {
        expect(authenticationRepository.logInWithGoogle(), completes);
      });

      test('throws LogInWithGoogleFailure when exception occurs', () async {
        when(mockFirebaseAuth.signInWithCredential(any)).thenThrow(Exception());
        expect(
          authenticationRepository.logInWithGoogle(),
          throwsA(isA<LogInWithGoogleFailure>()),
        );
      });
    });

    group('logInWithEmailAndPassword', () {
      setUp(() {
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenAnswer((_) async => _FakeUserCredential());
      });

      test('calls signInWithEmailAndPassword', () async {
        await authenticationRepository.logInWithEmailAndPassword(
          email: email,
          password: password,
        );
        verify(mockFirebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password,
        )).called(1);
      });

      test('succeeds when signInWithEmailAndPassword succeeds', () async {
        expect(
          authenticationRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          completes,
        );
      });

      test(
          'throws LogInWithEmailAndPasswordFailure '
          'when signInWithEmailAndPassword throws', () async {
        when(mockFirebaseAuth.signInWithEmailAndPassword(
          email: anyNamed('email'),
          password: anyNamed('password'),
        )).thenThrow(Exception());
        expect(
          authenticationRepository.logInWithEmailAndPassword(
            email: email,
            password: password,
          ),
          throwsA(isA<LogInWithEmailAndPasswordFailure>()),
        );
      });
    });

    group('logOut', () {
      test('calls signOut', () async {
        when(mockFirebaseAuth.signOut()).thenAnswer((_) async => null);
        when(mockGoogleSignIn.signOut()).thenAnswer((_) async => null);
        await authenticationRepository.logOut();
        verify(mockFirebaseAuth.signOut()).called(1);
        verify(mockGoogleSignIn.signOut()).called(1);
      });

      test('throws LogOutFailure when signOut throws', () async {
        when(mockFirebaseAuth.signOut()).thenThrow(Exception());
        expect(
          authenticationRepository.logOut(),
          throwsA(isA<LogOutFailure>()),
        );
      });
    });

    group('user', () {
      test('emits User.empty when firebase user is null', () async {
        when(mockFirebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(null),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[User.empty]),
        );
      });

      test('emits User when firebase user is not null', () async {
        final mockFirebaseUser = MockFirebaseUser();
        when(mockFirebaseUser.uid).thenReturn(_mockFirebaseUserUid);
        when(mockFirebaseUser.email).thenReturn(_mockFirebaseUserEmail);
        when(mockFirebaseUser.displayName).thenReturn(null);
        when(mockFirebaseUser.photoURL).thenReturn(null);
        when(mockFirebaseAuth.authStateChanges()).thenAnswer(
          (_) => Stream.value(mockFirebaseUser),
        );
        await expectLater(
          authenticationRepository.user,
          emitsInOrder(const <User>[user]),
        );
      });
    });
  });
}
