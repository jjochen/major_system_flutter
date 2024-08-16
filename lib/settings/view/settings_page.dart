import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/authentication/authentication.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    super.key,
  });

  static Route<dynamic> route() {
    return MaterialPageRoute<void>(builder: (_) => const SettingsPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            key: const Key('settingsPage_attributions_listTile'),
            leading: const Icon(Icons.info_outlined),
            title: const Text('Attributions'),
            trailing: const Icon(Icons.chevron_right_outlined),
            onTap: () =>
                Navigator.of(context).push<void>(AttributionsPage.route()),
          ),
          ListTile(
            key: const Key('settingsPage_maxNumberOfDigits_listTile'),
            leading: const Icon(Icons.numbers_outlined),
            title: const Text('Maximum number of digits'),
            onTap: () {},
          ),
          ListTile(
            // TODO(jjochen): Do not show if user is anonymous
            key: const Key('settingsPage_logout_listTile'),
            leading: const Icon(Icons.logout_outlined),
            title: const Text('Log out'),
            onTap: () => context
                .read<AuthenticationBloc>()
                .add(AuthenticationLogoutRequested()),
          ),
        ],
      ),
    );
  }
}
