import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumbersPage extends StatelessWidget {
  const NumbersPage({
    required this.user,
    super.key,
  });

  static Route<dynamic> route({
    required UserInfo user,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => NumbersPage(
        user: user,
      ),
    );
  }

  final UserInfo user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Major System'),
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
      body: BlocProvider(
        create: (context) => NumbersBloc(
          numbersRepository: FirebaseNumbersRepository(userId: user.id),
        ),
        child: const Numbers(),
      ),
    );
  }
}
