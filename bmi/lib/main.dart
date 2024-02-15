import 'package:flutter/material.dart';

void main() {
  runApp(BMICalculatorApp());
}

class BMICalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BMICalculatorScreen(),
    );
  }
}

class BMICalculatorScreen extends StatefulWidget {
  @override
  _BMICalculatorScreenState createState() => _BMICalculatorScreenState();
}

class _BMICalculatorScreenState extends State<BMICalculatorScreen> {
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  double? bmiResult;
  String? bmiInterpretation;
  String? errorMessage;

  void calculateBMI() {
    String? heightText = heightController.text.trim();
    String? weightText = weightController.text.trim();

    if (heightText.isEmpty || weightText.isEmpty) {
      setState(() {
        errorMessage = 'Please enter both height and weight.';
        bmiResult = null;
        bmiInterpretation = null;
      });
      return;
    }

    double height = double.tryParse(heightText) ?? 0;
    double weight = double.tryParse(weightText) ?? 0;

    if (height <= 0 || weight <= 0) {
      setState(() {
        errorMessage = 'Please enter valid numeric values for height and weight.';
        bmiResult = null;
        bmiInterpretation = null;
      });
      return;
    }

    double bmi = calculateBMIValue(height, weight);
    setState(() {
      bmiResult = bmi;
      bmiInterpretation = interpretBMI(bmi);
      errorMessage = null;
    });
  }

  double calculateBMIValue(double height, double weight) {
    return weight / ((height / 100) * (height / 100));
  }

  String interpretBMI(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obese';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Height (cm)'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            if (errorMessage != null)
              Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            if (bmiResult != null && bmiInterpretation != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Your BMI: ${bmiResult!.toStringAsFixed(1)}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('Interpretation: $bmiInterpretation'),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
