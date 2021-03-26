import 'package:flutter/material.dart';
import 'package:major_system/splash/splash.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashPage', () {
    testWidgets('renders bloc image', (tester) async {
      await tester.pumpWidget(MaterialApp(home: SplashPage()));
      expect(find.byKey(const Key('splash_bloc_image')), findsOneWidget);
    });
  });
}
