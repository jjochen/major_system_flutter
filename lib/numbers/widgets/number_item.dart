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
    return ListTile(
      onTap: onTap,
      title: Text(
        number.value.toString(),
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
