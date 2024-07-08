import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:numbers_repository/numbers_repository.dart';

class MockNumbersBloc extends MockBloc<NumbersEvent, NumbersState>
    implements NumbersBloc {}

void main() {
  const number = Number(id: 'id', numberOfDigits: 1, value: 1);
  const numbers = [number];

  group('Numbers Widget', () {
    late MockNumbersBloc numbersBloc;

    Widget buildFrame() => MaterialApp(
          home: Scaffold(
            body: BlocProvider<NumbersBloc>.value(
              value: numbersBloc,
              child: const NumbersList(),
            ),
          ),
        );

    setUp(() {
      numbersBloc = MockNumbersBloc();
    });

    testWidgets('renders LoadingIndicator when state is NumbersLoading',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream<NumbersState>.fromIterable([]),
        initialState: const NumbersLoading(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pump();

      expect(find.byType(LoadingIndicator), findsOneWidget);
    });

    testWidgets('renders ListView.builder when state is NumbersLoaded',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream<NumbersState>.fromIterable(const [NumbersLoaded(numbers)]),
        initialState: const NumbersLoading(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(NumberItem), findsNWidgets(numbers.length));
    });

    testWidgets('renders empty Container when state is not NumbersNotLoaded',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream.fromIterable(const [
          NumbersNotLoaded(),
        ]),
        initialState: const NumbersLoading(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(Container), findsOneWidget);
    });
  });
}
