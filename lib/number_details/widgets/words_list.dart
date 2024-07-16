import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/number_details.dart';

class WordsList extends StatelessWidget {
  const WordsList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberDetailsCubit, NumberDetailsState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: state.words.length,
          separatorBuilder: (context, index) => const Divider(),
          itemBuilder: (context, index) {
            final word = state.words[index];
            return ListTile(
              title: Text(word.value),
              onTap: () {
                context.read<NumberDetailsCubit>().selectMainWord(word);
              },
            );
          },
        );
      },
    );
  }
}
