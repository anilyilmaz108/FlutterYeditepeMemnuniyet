import 'package:flutter/material.dart';

class CalculatorService extends ChangeNotifier{
  double pieChartCalculator(double list1, double list2, double list3, double list4, double list5){
    double denominator = list1 + list2 + list3 + list4 + list5;
    double value = list1 / denominator;
    double valuePercentage = value * 100;
    return valuePercentage;
  }

  double progressItemCalculator(double list1, double list2, double list3, double list4, double list5){
    double denominator = list1 + list2 + list3 + list4 + list5;
    double value = list1 / denominator;
    double valuePercentage = value;
    return valuePercentage;
  }
}