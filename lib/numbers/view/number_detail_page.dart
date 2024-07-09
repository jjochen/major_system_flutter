import 'package:flutter/material.dart';
import 'package:numbers_repository/numbers_repository.dart';

class NumberDetailPage extends StatelessWidget {
  const NumberDetailPage({
    required this.number,
    super.key,
  });

  final Number number;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(number.toString()),
      ),
      body: Center(
        child: Text(number.value.toString()),
      ),
    );
  }
}
