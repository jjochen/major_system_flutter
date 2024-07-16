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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            number.toString(),
            style: Theme.of(context).textTheme.displayLarge,
          ),
          if (mainWord != null)
            Text(
              mainWord,
              style: Theme.of(context).textTheme.displayMedium,
            ),
        ],
      ),
    );
  }
}
