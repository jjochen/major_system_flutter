import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/numbers/numbers.dart';

class NumberDetailPage extends StatelessWidget {
  const NumberDetailPage({super.key});

  static Page<void> page() => const MaterialPage<void>(
        child: NumberDetailPage(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Number Details'),
      ),
      body: Center(
        child: BlocBuilder<NumbersBloc, NumbersState>(
          builder: (context, state) {
            final number = state.selectedNumber;
            if (number != null) {
              return Text(number.value.toString());
            } else {
              return const Text('No number selected');
            }
          },
        ),
      ),
    );
  }
}
