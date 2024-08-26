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
        return ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 24),
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
          separatorBuilder: (context, index) {
            return const Divider();
          },
        );
      },
    );
  }
}
