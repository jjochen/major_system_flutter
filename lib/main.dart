import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:major_system/app/services/service_locator.dart';
import 'package:major_system/app/view/app.dart';
import 'package:major_system/simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Bloc.observer = SimpleBlocObserver();
  ServiceLocator.setup();

  runApp(
    const App(
      authenticationRepository: AuthenticationRepository(),
    ),
  );
}
