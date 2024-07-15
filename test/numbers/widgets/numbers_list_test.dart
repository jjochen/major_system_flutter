import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/view/number_details_page.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

class MockNumbersBloc extends MockBloc<NumbersEvent, NumbersState>
    implements NumbersBloc {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  const number1 = Number(id: 'id', numberOfDigits: 1, value: 1);
  const number2 = Number(id: 'id', numberOfDigits: 1, value: 2);
  const numbers = [number1, number2];

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

    // testWidgets('renders LoadingIndicator when state is NumbersLoading',
    //     (WidgetTester tester) async {
    //   whenListen(
    //     numbersBloc,
    //     Stream<NumbersState>.fromIterable([]),
    //     initialState: const NumbersState(loading: true),
    //   );

    //   await tester.pumpWidget(buildFrame());
    //   await tester.pump();

    //   expect(find.byType(LoadingIndicator), findsOneWidget);
    // });

    testWidgets('renders ListView.builder when state is NumbersLoaded',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream<NumbersState>.fromIterable(
          const [NumbersState(numbers: numbers)],
        ),
        initialState: const NumbersState(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(NumberItem), findsNWidgets(numbers.length));
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('pushes NumberDetailPage when NumberItem is tapped',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream<NumbersState>.fromIterable(
          [const NumbersState(numbers: numbers)],
        ),
        initialState: const NumbersState(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      final numberItemFinder = find.byType(NumberItem).first;
      await tester.tap(numberItemFinder);
      await tester.pumpAndSettle();

      expect(find.byType(NumberDetailsPage), findsOneWidget);
    });
  });
}
