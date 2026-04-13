import 'package:flutter_test/flutter_test.dart';

import 'package:car_showroom_app/app.dart';

void main() {
  testWidgets('Splash shows app title', (WidgetTester tester) async {
    await tester.pumpWidget(const CarShowroomApp());
    expect(find.text('Car Showroom'), findsOneWidget);
  });
}
