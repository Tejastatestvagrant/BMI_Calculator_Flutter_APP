import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BMI Calculator Tests', () {
    test('Calculate BMI with valid inputs', () {
      double height = 170; // in centimeters
      double weight = 70; // in kilograms

      double expectedBMI = 24.22; // Expected BMI value

      double calculatedBMI = _calculateBMI(height, weight);

      expect(calculatedBMI, expectedBMI);
    });

    test('Calculate BMI with zero height', () {
      double height = 0; // Zero height
      double weight = 70; // in kilograms

      double calculatedBMI = _calculateBMI(height, weight);

      expect(calculatedBMI.isNaN, true); // BMI should be NaN for zero height
    });

    test('Calculate BMI with zero weight', () {
      double height = 170; // in centimeters
      double weight = 0; // Zero weight

      double calculatedBMI = _calculateBMI(height, weight);

      expect(calculatedBMI.isNaN, true); // BMI should be NaN for zero weight
    });

    test('Calculate BMI with negative height', () {
      double height = -170; // Negative height
      double weight = 70; // in kilograms

      double calculatedBMI = _calculateBMI(height, weight);

      expect(calculatedBMI.isNaN, true); // BMI should be NaN for negative height
    });

    test('Calculate BMI with negative weight', () {
      double height = 170; // in centimeters
      double weight = -70; // Negative weight

      double calculatedBMI = _calculateBMI(height, weight);

      expect(calculatedBMI.isNaN, true); // BMI should be NaN for negative weight
    });
  });
}

// Function to calculate BMI (extracted from the BMI Calculator screen for testing)
double _calculateBMI(double height, double weight) {
  return weight / ((height / 100) * (height / 100));
}
