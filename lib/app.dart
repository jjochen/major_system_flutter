import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/home/home.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/splash/splash.dart';
import 'package:major_system/theme.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository, super.key,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  AppViewState createState() => AppViewState();
}

class AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator?.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator?.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
              case AuthenticationStatus.unknown:
                // TODO(jjochen): Handle this case.
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
