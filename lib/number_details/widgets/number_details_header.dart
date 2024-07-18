import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberDetailsHeader extends StatelessWidget {
  const NumberDetailsHeader({
    required this.number,
    super.key,
  });

  final Number number;

  @override
  Widget build(BuildContext context) {
    final mainWord = number.mainWord;
    if (mainWord == null) return const SizedBox();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Text(
        mainWord,
        style: Theme.of(context).textTheme.displayMedium,
      ),
    );
  }
}
