import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:major_system/numbers/widgets/widgets.dart';

class Numbers extends StatelessWidget {
  const Numbers({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumbersBloc, NumbersState>(
      builder: (context, state) {
        if (state is NumbersLoading) {
          return const LoadingIndicator();
        } else if (state is NumbersLoaded) {
          final numbers = state.numbers;
          return ListView.builder(
            itemCount: numbers.length,
            itemBuilder: (context, index) {
              final number = numbers[index];
              return NumberItem(
                number: number,
                onDismissed: (direction) {
                  BlocProvider.of<NumbersBloc>(context)
                      .add(DeleteNumber(number));
                  ScaffoldMessenger.of(context).showSnackBar(
                    DeleteNumberSnackBar(
                      number: number,
                      onUndo: () => BlocProvider.of<NumbersBloc>(context)
                          .add(AddNumber(number)),
                    ),
                  );
                },
                onTap: () async {
                  final removedNumber = await Navigator.of(context).push(
                    MaterialPageRoute<dynamic>(
                      builder: (_) {
                        // TODO(jjochen): Implement DetailsScreen.
                        return Container();
                        //return DetailsScreen(id: number.id);
                      },
                    ),
                  );
                  if (removedNumber != null && context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      DeleteNumberSnackBar(
                        number: number,
                        onUndo: () => BlocProvider.of<NumbersBloc>(context)
                            .add(AddNumber(number)),
                      ),
                    );
                  }
                },
              );
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
