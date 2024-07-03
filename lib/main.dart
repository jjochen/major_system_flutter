import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:major_system/app.dart';
import 'package:major_system/simple_bloc_observer.dart';
import 'package:numbers_repository/numbers_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  runApp(
    App(
      authenticationRepository: const AuthenticationRepository(),
      numbersRepository: FirebaseNumbersRepository(),
    ),
  );
}
