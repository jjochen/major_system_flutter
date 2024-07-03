import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberItem extends StatelessWidget {
  const NumberItem({
    required this.onDismissed,
    required this.onTap,
    required this.number,
    super.key,
  });

  final DismissDirectionCallback onDismissed;
  final GestureTapCallback onTap;
  final Number number;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key('__number_item_${number.id}'),
      onDismissed: onDismissed,
      child: ListTile(
        onTap: onTap,
        title: Text(
          number.toString(),
          style: Theme.of(context).textTheme.displayMedium,
        ),
      ),
    );
  }
}
