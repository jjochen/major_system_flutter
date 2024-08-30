import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/view/number_details_page.dart';
import 'package:major_system/numbers/cubit/numbers_cubit.dart';
import 'package:major_system/numbers/widgets/widgets.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumbersList extends StatelessWidget {
  const NumbersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumbersCubit, NumbersState>(
      builder: (context, state) {
        final numbers = state.numbers;
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            childAspectRatio: 1.618,
          ),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          itemCount: numbers.length,
          itemBuilder: (context, index) {
            final number = numbers[index];
            return NumberItem(
              number: number,
              onTap: () async {
                final repository = context.read<NumbersRepository>();
                await Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) => NumberDetailsPage(
                      number: number,
                      numbersRepository: repository,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
