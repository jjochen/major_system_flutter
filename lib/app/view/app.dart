import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/app/flow/app_flow.dart';
import 'package:major_system/authentication/authentication.dart';

class App extends StatelessWidget {
  const App({
    required this.authenticationRepository,
    super.key,
  });

  final AuthenticationRepository authenticationRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationRepository>(
      create: (context) => authenticationRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => AuthenticationBloc(
          authenticationRepository: authenticationRepository,
        ),
        child: const MaterialApp(
          home: AppFlow(),
        ),
      ),
    );
  }
}
