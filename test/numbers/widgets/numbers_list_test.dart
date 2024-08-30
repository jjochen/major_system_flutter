import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/view/number_details_page.dart';
import 'package:major_system/numbers/numbers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

import '../../mocks/number_repository_mocks.dart';

class MockNumbersCubit extends MockCubit<NumbersState>
    implements NumbersCubit {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUpAll(() async {
    registerFallbackValue(number1);
    registerFallbackValue(word1);
  });

  group('Numbers Widget', () {
    late NumbersCubit numbersCubit;
    late NumbersRepository numbersRepository;

    Widget buildFrame() => MaterialApp(
          home: Scaffold(
            body: RepositoryProvider<NumbersRepository>.value(
              value: numbersRepository,
              child: BlocProvider<NumbersCubit>.value(
                value: numbersCubit,
                child: const NumbersList(),
              ),
            ),
          ),
        );

    setUp(() {
      numbersCubit = MockNumbersCubit();
      numbersRepository = MockNumbersRepository();
    });

    testWidgets('renders GridView when state is NumbersLoaded',
        (WidgetTester tester) async {
      whenListen(
        numbersCubit,
        Stream<NumbersState>.fromIterable(
          const [NumbersState(numbers: numbers)],
        ),
        initialState: const NumbersState(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(GridView), findsOneWidget);
      expect(find.byType(NumberItem), findsNWidgets(numbers.length));
    });

    testWidgets('pushes NumberDetailPage when NumberItem is tapped',
        (WidgetTester tester) async {
      whenListen(
        numbersCubit,
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
