import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/number_details.dart';

class NumberDetailsView extends StatelessWidget {
  const NumberDetailsView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NumberDetailsCubit, NumberDetailsState>(
      builder: (context, state) {
        if (state is! NumberSelected) return const SizedBox();

        final number = state.number;
        return Scaffold(
          appBar: AppBar(
            title: Text(number.toString()),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NumberDetailsHeader(number: number),
              const Expanded(child: WordsList()),
            ],
          ),
        );
      },
    );
  }
}
