import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumbersPage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => NumbersPage());
  }

  @override
  Widget build(BuildContext context) {
// final textTheme = Theme.of(context).textTheme;
    //final userInfo =
    context.select((AuthenticationBloc bloc) => bloc.state.userInfo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          IconButton(
            key: const Key('homePage_attributions_iconButton'),
            icon: const Icon(Icons.info_outline),
            onPressed: () =>
                Navigator.of(context).push<void>(AttributionsPage.route()),
          ),
          IconButton(
            key: const Key('homePage_logout_iconButton'),
            icon: const Icon(Icons.exit_to_app_outlined),
            onPressed: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          ),
        ],
      ),
      body: BlocProvider<NumbersBloc>(
        create: (_) {
          return NumbersBloc(
              numbersRepository: context.read<NumbersRepository>(),
              authenticationBloc: context.read<AuthenticationBloc>())
            ..add(LoadNumbers()); // TODO add LoadNumbers when authenticated
        },
        child: Numbers(),
      ),
    );
  }
}
