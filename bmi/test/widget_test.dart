import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bmi/main.dart';

void main() {
  testWidgets('BMI Calculator UI Test', (WidgetTester tester) async {
    // Build the BMI Calculator screen
    await tester.pumpWidget(BMICalculatorApp());

    // Verify the initial state of the app
    expect(find.text('BMI Calculator'), findsOneWidget);
    expect(find.text('Height (cm)'), findsOneWidget);
    expect(find.text('Weight (kg)'), findsOneWidget);
    expect(find.text('Calculate BMI'), findsOneWidget);

    // Enter valid inputs and calculate BMI
    await tester.enterText(find.byKey(ValueKey('heightTextField')), '170');
    await tester.enterText(find.byKey(ValueKey('weightTextField')), '70');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    // Verify the result display
    expect(find.text('Your BMI: 24.2'), findsOneWidget);
    expect(find.text('Interpretation: Normal weight'), findsOneWidget);

    // Test input validation with invalid inputs
    await tester.enterText(find.byKey(ValueKey('heightTextField')), ''); // Empty height
    await tester.enterText(find.byKey(ValueKey('weightTextField')), '70');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    // Verify error message for empty height
    expect(find.text('Please enter both height and weight.'), findsOneWidget);

    // Test input validation with negative inputs
    await tester.enterText(find.byKey(ValueKey('heightTextField')), '-170'); // Negative height
    await tester.enterText(find.byKey(ValueKey('weightTextField')), '70');
    await tester.tap(find.text('Calculate BMI'));
    await tester.pump();

    // Verify error message for negative height
    expect(find.text('Please enter valid numeric values for height and weight.'), findsOneWidget);
  });
}
