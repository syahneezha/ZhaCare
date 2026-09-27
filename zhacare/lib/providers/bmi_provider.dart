import 'package:flutter/material.dart';
import '../data/models/bmi_model.dart';

class BmiProvider extends ChangeNotifier {
  double _height = 168.0; // cm
  double _weight = 62.0;  // kg
  String _gender = 'male'; // 'male' | 'female'
  BmiResult? _result;
  final List<BmiResult> _history = [];

  BmiProvider() {
    // Inisialisasi kalkulasi awal agar dashboard langsung terisi nilai
    calculate();
  }

  double get height => _height;
  double get weight => _weight;
  String get gender => _gender;
  BmiResult? get result => _result;
  List<BmiResult> get history => List.unmodifiable(_history);

  void setHeight(double value) {
    if (value >= 100 && value <= 230) {
      _height = double.parse(value.toStringAsFixed(1));
      notifyListeners();
    }
  }

  void setWeight(double value) {
    if (value >= 30 && value <= 200) {
      _weight = double.parse(value.toStringAsFixed(1));
      notifyListeners();
    }
  }

  void setGender(String value) {
    if (_gender != value) {
      _gender = value;
      notifyListeners();
    }
  }

  void calculate() {
    final newResult = BmiResult.calculate(
      weightKg: _weight,
      heightCm: _height,
    );
    _result = newResult;
    _history.insert(0, newResult);
    if (_history.length > 5) {
      _history.removeLast();
    }
    notifyListeners();
  }

  void reset() {
    _height = 168.0;
    _weight = 62.0;
    _gender = 'male';
    calculate();
  }
}
