import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberItem extends StatelessWidget {
  const NumberItem({
    required this.onTap,
    required this.number,
    super.key,
  });

  final GestureTapCallback onTap;
  final Number number;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final title = number.toString();
    final subtitle = number.mainWord;
    return ListTile(
      onTap: onTap,
      title: Text(
        title,
        style: textTheme.headlineSmall,
      ),
      subtitle: subtitle == null
          ? null
          : Text(
              subtitle,
              style: textTheme.bodyMedium,
            ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(
          color: Colors.grey,
          width: 0.5,
        ),
      ),
    );
  }
}
