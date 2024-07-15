import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/cubit/number_details_cubit.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberDetailsPage extends StatelessWidget {
  const NumberDetailsPage({
    required this.number,
    super.key,
  });

  final Number number;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberDetailsCubit(
        numbersRepository: context.read<NumbersRepository>(),
      )..selectNumber(number),
      child: const NumberDetailsView(),
    );
  }
}

class NumberDetailsView extends StatelessWidget {
  const NumberDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberDetailsCubit, NumberDetailsState>(
      builder: (context, state) {
        if (state is NumberSelected) {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.number.toString()),
            ),
            body: ListView(
              children: [
                ListTile(
                  title: Text(
                    '${state.number} - ${state.number.mainWord}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(
                    'Words',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.words.length,
                  itemBuilder: (context, index) {
                    final word = state.words[index];
                    return ListTile(
                      title: Text(word.value),
                      onTap: () {
                        // TODO: Handle word selection
                      },
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(),
          );
        }
      },
    );
  }
}
