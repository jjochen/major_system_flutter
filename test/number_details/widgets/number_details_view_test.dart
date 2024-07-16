// ignore_for_file: prefer_const_constructors

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/number_details.dart';

import '../../mocks/number_repository_mocks.dart';
import 'words_list_test.dart';

void main() {
  group('NumberDetailsView', () {
    late MockNumberDetailsCubit mockCubit;

    setUp(() {
      mockCubit = MockNumberDetailsCubit();
    });

    MaterialApp buildFrame() {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<NumberDetailsCubit>.value(
            value: mockCubit,
            child: const NumberDetailsView(),
          ),
        ),
      );
    }

    testWidgets('renders correctly', (WidgetTester tester) async {
      whenListen(
        mockCubit,
        Stream<NumberDetailsState>.empty(),
        initialState:
            NumberDetailsState(number: mainNumber, words: const [word1, word2]),
      );

      await tester.pumpWidget(buildFrame());

      expect(find.byType(NumberDetailsHeader), findsOneWidget);
      expect(find.byType(WordsList), findsOneWidget);
    });

    testWidgets('renders correctly without number',
        (WidgetTester tester) async {
      whenListen(
        mockCubit,
        Stream<NumberDetailsState>.empty(),
        initialState: NumberDetailsState(),
      );

      await tester.pumpWidget(buildFrame());

      expect(find.byType(NumberDetailsHeader), findsNothing);
      expect(find.byType(WordsList), findsNothing);
    });
  });
}
