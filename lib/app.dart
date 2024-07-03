import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/splash/splash.dart';
import 'package:major_system/theme.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    super.key,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    final authenticationBloc =
        AuthenticationBloc(authenticationRepository: authenticationRepository);

    return RepositoryProvider<AuthenticationRepository>(
      create: (context) => authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
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
            if (state is AuthenticationAuthenticated) {
              _navigator?.pushAndRemoveUntil<void>(
                NumbersPage.route(user: state.user),
                (route) => false,
              );
            } else {
              _navigator?.pushAndRemoveUntil<void>(
                LoginPage.route(),
                (route) => false,
              );
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
