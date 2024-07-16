import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:major_system/number_details/number_details.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberDetailsPage extends StatelessWidget {
  const NumberDetailsPage({
    required this.number,
    required this.numbersRepository,
    super.key,
  });

  final Number number;
  final NumbersRepository numbersRepository;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NumberDetailsCubit(
        numbersRepository: numbersRepository,
      )..selectNumber(number),
      child: const NumberDetailsView(),
    );
  }
}
