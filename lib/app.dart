import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/splash/splash.dart';
import 'package:major_system/theme.dart';
import 'package:numbers_repository/numbers_repository.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    required this.numbersRepository,
    super.key,
  });

  final AuthenticationRepository authenticationRepository;
  final NumbersRepository numbersRepository;

  @override
  Widget build(BuildContext context) {
    final authenticationBloc =
        AuthenticationBloc(authenticationRepository: authenticationRepository);
    final numbersBloc = NumbersBloc(
      numbersRepository: numbersRepository,
      authenticationBloc: authenticationBloc,
    );
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthenticationRepository>(
          create: (context) => authenticationRepository,
        ),
        RepositoryProvider<NumbersRepository>(
          create: (context) => numbersRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
            create: (context) => authenticationBloc,
          ),
          BlocProvider<NumbersBloc>(create: (context) => numbersBloc),
        ],
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
                  NumbersPage.route(),
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
