import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/attributions/attributions.dart';
import 'package:major_system/settings/cubit/settings_cubit.dart';
import 'package:numbers_repository/numbers_repository.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({
    required this.authenticationRepository,
    required this.numbersRepository,
    super.key,
  });

  final AuthenticationRepository authenticationRepository;
  final NumbersRepository numbersRepository;

  static Route<dynamic> route({
    required AuthenticationRepository authenticationRepository,
    required NumbersRepository numbersRepository,
  }) {
    return MaterialPageRoute<void>(
      builder: (_) => SettingsPage(
        authenticationRepository: authenticationRepository,
        numbersRepository: numbersRepository,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: BlocProvider<SettingsCubit>(
        create: (_) => SettingsCubit(
          authenticationRepository: authenticationRepository,
          numbersRepository: numbersRepository,
        ),
        child: const SettingsBody(),
      ),
    );
  }
}

class SettingsBody extends StatelessWidget {
  const SettingsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final maxDigitsValue =
            state.maxNumberOfDigits == 0 ? null : state.maxNumberOfDigits;
        return ListView(
          children: [
            ListTile(
              key: const Key('settingsPage_maxNumberOfDigits_listTile'),
              leading: const Icon(Icons.numbers_outlined),
              title: const Text('Max number of digits'),
              trailing: DropdownButton<int>(
                key: const Key('settingsPage_maxNumberOfDigits_dropdownButton'),
                value: maxDigitsValue,
                onChanged: (int? newValue) {
                  if (newValue == null) return;
                  context.read<SettingsCubit>().setMaxNumberOfDigits(newValue);
                },
                items: List.generate(
                  4,
                  (index) => DropdownMenuItem<int>(
                    key: Key(
                      'settingsPage_maxNumberOfDigits_dropdownItem_$index',
                    ),
                    value: index + 1,
                    child: Text('${index + 1}'),
                  ),
                ),
              ),
              // onTap: () async {
              //   final newValue = await showDialog<int>(
              //     context: context,
              //     builder: (BuildContext context) {
              //       return AlertDialog(
              //         title: const Text('Maximum number of digits'),
              //         content: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             for (int i = 1; i <= 4; i++)
              //               RadioListTile<int>(
              //                 title: Text('$i'),
              //                 value: i,
              //                 groupValue: state.maxNumberOfDigits,
              //                 onChanged: (int? value) {
              //                   Navigator.of(context).pop(value);
              //                 },
              //               ),
              //           ],
              //         ),
              //       );
              //     },
              //   );

              //   if (newValue == null) return;
              //   if (!context.mounted) return;

              //   context.read<SettingsCubit>().setMaxNumberOfDigits(newValue);
              // },
            ),
            ListTile(
              key: const Key('settingsPage_attributions_listTile'),
              leading: const Icon(Icons.info_outlined),
              title: const Text('Attributions'),
              trailing: const Icon(Icons.chevron_right_outlined),
              onTap: () =>
                  Navigator.of(context).push<void>(AttributionsPage.route()),
            ),
            ListTile(
              // TODO(jjochen): Do not show if user is anonymous
              key: const Key('settingsPage_logout_listTile'),
              leading: const Icon(Icons.logout_outlined),
              title: const Text('Log out'),
              onTap: () => context.read<SettingsCubit>().logOut(),
            ),
          ],
        );
      },
    );
  }
}
