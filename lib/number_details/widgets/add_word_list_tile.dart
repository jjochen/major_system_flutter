import 'package:flutter/material.dart';

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
      onTap: () {
        // TODO: Implement edit word screen
      },
    );
  }
}
