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
      title: const Text('Add new word'),
      leading: const Icon(Icons.add_circle_outline),
      onTap: () async {
        final word = await _addWord(context);
        if (word == null || word.isEmpty) return;
        if (!context.mounted) return;
        context.read<NumberDetailsCubit>().addWord(word);
      },
    );
  }

  Future<String?> _addWord(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        var word = '';
        return AlertDialog(
          title: const Text('Add Word'),
          content: TextField(
            onChanged: (value) {
              word = value;
            },
            decoration: const InputDecoration(
              labelText: 'Word',
            ),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(word);
              },
              child: const Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
