import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/app/services/service_locator.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:major_system/settings/view/view.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumbersPage extends StatelessWidget {
  const NumbersPage({
    required this.user,
    super.key,
  });

  final UserInfo user;

  static Page<void> page({required UserInfo user}) => MaterialPage<void>(
        child: NumbersPage(user: user),
      );

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<NumbersRepository>(
      create: (context) => FirebaseNumbersRepository(
        userId: user.id,
        firestore: getIt(),
      ),
      child: Builder(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Major System'),
            actions: <Widget>[
              IconButton(
                key: const Key('homePage_settings_iconButton'),
                icon: const Icon(Icons.settings_outlined),
                onPressed: () => Navigator.of(context).push<void>(
                  SettingsPage.route(
                    authenticationRepository:
                        context.read<AuthenticationRepository>(),
                    numbersRepository: context.read<NumbersRepository>(),
                  ),
                ),
              ),
            ],
          ),
          body: BlocProvider(
            create: (context) => NumbersCubit(
              numbersRepository: context.read<NumbersRepository>(),
            )..loadNumbers(),
            child: const NumbersList(),
          ),
        ),
      ),
    );
  }
}
