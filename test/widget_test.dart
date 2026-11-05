import 'package:flutter_test/flutter_test.dart';
import 'package:campus_news_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('Campus News app displays its home title', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const CampusNewsApp());
    await tester.pump();
    expect(find.text('Campus News'), findsOneWidget);
  });
}
