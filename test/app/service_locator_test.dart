import 'package:flutter_test/flutter_test.dart';
import 'package:major_system/app/services/service_locator.dart';

void main() {
  group('ServiceLocator.setup', () {
    testWidgets('registers dependencies', (tester) async {
      TestWidgetsFlutterBinding.ensureInitialized();
      ServiceLocator.setup();
    });
  });
}
