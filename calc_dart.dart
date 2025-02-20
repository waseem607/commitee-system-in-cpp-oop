import 'dart:io';

double add(double a, double b) {
  return a + b;
}

double subtract(double a, double b) {
  return a - b;
}

double multiply(double a, double b) {
  return a * b;
}

double divide(double a, double b) {
  if (b == 0) {
    print('Error: Division by zero');
    return double.nan;
  }
  return a / b;
}

void main() {
  print('Simple Calculator');
  
  print('Enter first number:');
  double num1 = double.parse(stdin.readLineSync());
  
  print('Enter second number:');
  double num2 = double.parse