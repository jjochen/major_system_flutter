import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/numbers/numbers.dart';

class NumbersFlow extends StatelessWidget {
  const NumbersFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<NumbersState>(
      state: context.select((NumbersBloc bloc) => bloc.state),
      onGeneratePages: (NumbersState state, List<Page<dynamic>> pages) {
        return [
          NumbersPage.page(),
          //if (state.selectedNumber != null) NumberDetailsPage.page(),
        ];
      },
    );
  }
}
