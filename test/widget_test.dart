import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tugas2/main.dart';

void main() {
  testWidgets('BMI calculator calculates and displays the result', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const AzyanApp());

    expect(find.text('Pilih gender'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));

    await tester.enterText(find.byType(TextField).at(0), '70');
    await tester.enterText(find.byType(TextField).at(1), '170');
    await tester.ensureVisible(find.text('Hitung BMI'));
    await tester.tap(find.text('Hitung BMI'));
    await tester.pump();

    expect(find.text('24.22'), findsOneWidget);
    expect(find.text('Kelebihan'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
