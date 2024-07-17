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
        return ListView.builder(
          itemCount: state.words.length + 1,
          itemBuilder: (context, index) {
            if (index == state.words.length) {
              return const AddWordListTile();
            } else {
              final word = state.words[index];
              return WordListTile(word: word);
            }
          },
        );
      },
    );
  }
}
