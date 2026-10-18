import 'package:flutter_test/flutter_test.dart';
import 'package:movieapp/core/di/injection.dart';
import 'package:movieapp/main.dart';

void main() {
  setUpAll(() {
    setupLocator();
  });

  testWidgets('App renders LoginPage smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Login here'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}
