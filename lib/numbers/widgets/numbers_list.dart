import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:major_system/numbers/widgets/widgets.dart';

class NumbersList extends StatelessWidget {
  const NumbersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumbersBloc, NumbersState>(
      builder: (context, state) {
        if (state is NumbersLoading) {
          return const LoadingIndicator();
        } else if (state is NumbersLoaded) {
          final numbers = state.numbers;
          return ListView.separated(
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final number = numbers[index];
              return NumberItem(
                number: number,
                onTap: () async {
                  await Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (_) {
                        // TODO(jjochen): Implement DetailsScreen.
                        return Container();
                        //return DetailsScreen(id: number.id);
                      },
                    ),
                  );
                },
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
