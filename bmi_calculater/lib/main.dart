import 'package:flutter/material.dart';

enum Gender { male, female }

void main() => runApp(const BMICalculator());

class BMICalculator extends StatefulWidget {
  const BMICalculator({super.key});

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  Gender? selectedGender;
  double height = 147.0;
  int weight = 60;
  int age = 20;

  double calculateBMI() {
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("BMI Calculator")),
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    GenderCard(
                      icon: Icons.male,
                      label: 'MALE',
                      isSelected: selectedGender == Gender.male,
                      onTap: () => setState(() => selectedGender = Gender.male),
                    ),
                    GenderCard(
                      icon: Icons.female,
                      label: 'FEMALE',
                      isSelected: selectedGender == Gender.female,
                      onTap: () => setState(() => selectedGender = Gender.female),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: CardSection(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("HEIGHT", style: TextStyle(color: Colors.white)),
                      Text(
                        "${height.round()} cm",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Slider(
                        value: height,
                        min: 100.0,
                        max: 220.0,
                        divisions: 120,
                        label: '${height.round()} cm',
                        onChanged: (value) => setState(() => height = value),
                        activeColor: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    ValueCard(
                      label: "WEIGHT",
                      value: weight,
                      onDecrement: () => setState(() => weight = weight > 0 ? weight - 1 : 0),
                      onIncrement: () => setState(() => weight++),
                    ),
                    ValueCard(
                      label: "AGE",
                      value: age,
                      onDecrement: () => setState(() => age = age > 0 ? age - 1 : 0),
                      onIncrement: () => setState(() => age++),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  final bmi = calculateBMI();
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("BMI Result"),
                      content: Text("Your BMI is ${bmi.toStringAsFixed(1)}"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                child: Container(
                  color: Colors.red,
                  height: 60,
                  width: double.infinity,
                  child: const Center(
                    child: Text(
                      "CALCULATE",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GenderCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const GenderCard({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: CardSection(
          color: isSelected ? const Color(0xFF2D2E44) : const Color(0xFF1D1E33),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 10),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}

class ValueCard extends StatelessWidget {
  final String label;
  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  const ValueCard({
    super.key,
    required this.label,
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CardSection(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: const TextStyle(color: Colors.white)),
            Text(
              '$value',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: onDecrement,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child: const Icon(Icons.remove, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: onIncrement,
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[800],
                    child: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CardSection extends StatelessWidget {
  final Widget child;
  final Color color;

  const CardSection({
    super.key,
    required this.child,
    this.color = const Color(0xFF1D1E33),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}