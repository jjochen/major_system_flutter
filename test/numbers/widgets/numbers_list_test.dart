import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
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
    setUpAll(() {
      registerFallbackValue(
        MaterialPageRoute<dynamic>(
          builder: (_) => Container(),
        ),
      );
    });

    late MockNumbersBloc numbersBloc;
    late MockNavigatorObserver mockNavigatorObserver;

    Widget buildFrame() => MaterialApp(
          navigatorObservers: [mockNavigatorObserver],
          home: Scaffold(
            body: BlocProvider<NumbersBloc>.value(
              value: numbersBloc,
              child: const NumbersList(),
            ),
          ),
        );

    setUp(() {
      numbersBloc = MockNumbersBloc();
      mockNavigatorObserver = MockNavigatorObserver();
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
      expect(find.byType(Divider), findsOneWidget);
    });

    testWidgets('navigates to DetailsScreen when NumberItem is tapped',
        (WidgetTester tester) async {
      whenListen(
        numbersBloc,
        Stream<NumbersState>.fromIterable(const [NumbersLoaded(numbers)]),
        initialState: const NumbersLoading(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      final numberItemFinder = find.byType(NumberItem).first;
      await tester.tap(numberItemFinder);
      await tester.pumpAndSettle();

      verify(
        () => mockNavigatorObserver.didPush(
          any(),
          any(),
        ),
      ).called(2);
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
