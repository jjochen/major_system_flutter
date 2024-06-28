import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';
import 'package:major_system/home/home.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Route<dynamic> route() {
    return MaterialPageRoute<void>(builder: (_) => const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = context.select((AuthenticationBloc bloc) => bloc.state.user);
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
      body: Align(
        alignment: const Alignment(0, -1 / 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Avatar(photo: user.photo),
            const SizedBox(height: 4),
            Text(user.email ?? '', style: textTheme.titleLarge),
            const SizedBox(height: 4),
            Text(user.name ?? '', style: textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}
