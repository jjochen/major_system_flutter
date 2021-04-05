import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberItem extends StatelessWidget {
  NumberItem({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.number,
  }) : super(key: key);

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
          number.toString(), // TODO
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
    );
  }
}
