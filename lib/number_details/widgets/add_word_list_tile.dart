import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/number_details.dart';

class AddWordListTile extends StatelessWidget {
  const AddWordListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foregroundColor = theme.colorScheme.primary;
    return ListTile(
      iconColor: foregroundColor,
      textColor: foregroundColor,
      titleTextStyle: theme.textTheme.titleMedium,
      title: const Text('Add a new word'),
      leading: const Icon(Icons.add_circle_outlined),
      onTap: () async {
        final word = await _addWord(context);
        if (word == null) return;
        if (!context.mounted) return;
        context.read<NumberDetailsCubit>().addWord(word);
      },
    );
  }

  Future<String?> _addWord(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return const AddWordDialog();
      },
    );
  }
}

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  AddWordDialogState createState() => AddWordDialogState();
}

class AddWordDialogState extends State<AddWordDialog> {
  String word = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: const Key('add_word_dialog'),
      title: const Text('Add Word'),
      content: TextField(
        key: const Key('add_word_dialog_text_field'),
        onChanged: (value) {
          setState(() {
            word = value;
          });
        },
        decoration: const InputDecoration(
          labelText: 'Word',
        ),
        autofocus: true,
      ),
      actions: [
        TextButton(
          key: const Key('add_word_dialog_save_button'),
          onPressed: word.isEmpty
              ? null
              : () {
                  Navigator.of(context).pop(word);
                },
          child: const Text('Save'),
        ),
        TextButton(
          key: const Key('add_word_dialog_cancel_button'),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('Cancel'),
        ),
      ],
    );
  }
}
