import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/login/login.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/splash/splash.dart';

class AppFlow extends StatelessWidget {
  const AppFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<AuthenticationState>(
      state: context.select((AuthenticationBloc bloc) => bloc.state),
      onGeneratePages: (AuthenticationState state, List<Page<dynamic>> pages) {
        if (state is AuthenticationAuthenticated) {
          return [
            NumbersPage.page(),
          ];
        } else if (state is AuthenticationUnauthenticated) {
          return [
            LoginPage.page(),
          ];
        } else {
          return [
            SplashPage.page(),
          ];
        }
      },
    );
  }
}
