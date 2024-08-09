import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/number_details.dart';
import 'package:mocktail/mocktail.dart';
import 'package:numbers_repository/numbers_repository.dart';

import '../../mocks/number_repository_mocks.dart';

class MockNumberDetailsCubit extends MockCubit<NumberDetailsState>
    implements NumberDetailsCubit {}

void main() {
  group('WordListTile', () {
    late NumberDetailsCubit cubit;

    setUp(() {
      cubit = MockNumberDetailsCubit();
      whenListen(
        cubit,
        const Stream<NumberDetailsState>.empty(),
        initialState: const NumberDetailsState(),
      );
    });

    Widget buildFrame(Word word) {
      return MaterialApp(
        home: Scaffold(
          body: BlocProvider<NumberDetailsCubit>.value(
            value: cubit,
            child: WordListTile(word: word),
          ),
        ),
      );
    }

    testWidgets('renders word value correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame(word1));
      await tester.pumpAndSettle();

      expect(find.text(word1.value), findsOneWidget);
    });

    testWidgets('renders check icon for main word',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame(mainWord));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_outlined), findsOneWidget);
    });

    testWidgets('does not render check icon for non-main word',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame(word2));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_outlined), findsNothing);
    });

    testWidgets('calls selectMainWord when tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame(word2));
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile));

      verify(() => cubit.selectMainWord(word2)).called(1);
    });
  });
}
