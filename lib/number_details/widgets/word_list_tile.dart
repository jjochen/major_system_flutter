import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/cubit/cubit.dart';
import 'package:numbers_repository/numbers_repository.dart';

class WordListTile extends StatelessWidget {
  const WordListTile({
    required this.word,
    super.key,
  });

  final Word word;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        word.value,
        style: Theme.of(context).textTheme.titleMedium,
      ),
      leading: word.isMain
          ? const Icon(Icons.check_outlined)
          : const SizedBox(width: 24),
      onTap: () {
        context.read<NumberDetailsCubit>().selectMainWord(word);
      },
    );
  }
}
