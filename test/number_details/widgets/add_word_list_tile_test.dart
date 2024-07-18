import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/number_details/number_details.dart';
import 'package:mocktail/mocktail.dart';

class MockNumberDetailsCubit extends MockCubit<NumberDetailsState>
    implements NumberDetailsCubit {}

void main() {
  group('AddWordListTile', () {
    late NumberDetailsCubit cubit;

    setUp(() {
      cubit = MockNumberDetailsCubit();
      whenListen(
        cubit,
        const Stream<NumberDetailsState>.empty(),
        initialState: const NumberDetailsState(),
      );
    });

    Widget buildFrame() {
      return MaterialApp(
        home: BlocProvider<NumberDetailsCubit>.value(
          value: cubit,
          child: const Scaffold(
            body: AddWordListTile(),
          ),
        ),
      );
    }

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      expect(find.byType(AddWordListTile), findsOneWidget);
    });

    testWidgets('shows dialog when tapped', (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      expect(
        find.byKey(const Key('add_word_dialog')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('add_word_dialog_text_field')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('add_word_dialog_save_button')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('add_word_dialog_cancel_button')),
        findsOneWidget,
      );
    });

    testWidgets('calls addWord when save button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const Key('add_word_dialog_text_field')),
        'new word',
      );
      await tester.tap(find.byKey(const Key('add_word_dialog_save_button')));
      await tester.pumpAndSettle();

      verify(() => cubit.addWord('new word')).called(1);
    });

    testWidgets('does not call addWord when cancel button is tapped',
        (WidgetTester tester) async {
      await tester.pumpWidget(buildFrame());
      await tester.pumpAndSettle();

      await tester.tap(find.byType(ListTile));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('add_word_dialog_cancel_button')));
      await tester.pumpAndSettle();

      verifyNever(() => cubit.addWord(any()));
    });
  });
}
