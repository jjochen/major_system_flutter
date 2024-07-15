import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/view/number_detail_page.dart';
import 'package:major_system/numbers/bloc/numbers_bloc.dart';
import 'package:major_system/numbers/widgets/widgets.dart';

class NumbersList extends StatelessWidget {
  const NumbersList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumbersBloc, NumbersState>(
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
                await Navigator.push(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (context) => NumberDetailPage(number: number),
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
