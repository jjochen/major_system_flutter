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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                'Words',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: state.words.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.words.length) {
                    return const AddWordListTile();
                  } else {
                    final word = state.words[index];
                    return WordListTile(word: word);
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
