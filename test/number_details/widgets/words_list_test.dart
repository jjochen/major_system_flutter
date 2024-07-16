// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/number_details.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/number_repository_mocks.dart';

class MockNumberDetailsCubit extends MockCubit<NumberDetailsState>
    implements NumberDetailsCubit {}

void main() {
  group('WordsList', () {
    late MockNumberDetailsCubit mockCubit;

    setUp(() {
      mockCubit = MockNumberDetailsCubit();
      whenListen(
        mockCubit,
        Stream<NumberDetailsState>.empty(),
        initialState: NumberDetailsState(),
      );
    });

    MaterialApp buildFrame() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<NumberDetailsCubit>.value(
            value: mockCubit,
            child: const WordsList(),
          ),
        ),
      );
    }

    testWidgets('WordsList widget builds correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('displays words correctly', (WidgetTester tester) async {
      whenListen(
        mockCubit,
        Stream<NumberDetailsState>.fromIterable([
          NumberDetailsState(number: number1, words: const [word1, word2]),
        ]),
        initialState: NumberDetailsState(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.text('one'), findsOneWidget);
      expect(find.text('two'), findsOneWidget);
    });

    testWidgets('selects main word on tap', (WidgetTester tester) async {
      whenListen(
        mockCubit,
        Stream<NumberDetailsState>.fromIterable([
          NumberDetailsState(number: number1, words: const [word1, word2]),
        ]),
        initialState: NumberDetailsState(),
      );

      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      await tester.tap(find.text('one'));
      verify(() => mockCubit.selectMainWord(word1)).called(1);
    });
  });
}
