import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

enum BmiCategory {
  underweight,
  normal,
  overweight,
  obese;

  String get label {
    switch (this) {
      case BmiCategory.underweight:
        return 'Berat Kurang';
      case BmiCategory.normal:
        return 'Normal & Ideal';
      case BmiCategory.overweight:
        return 'Kelebihan Berat';
      case BmiCategory.obese:
        return 'Obesitas';
    }
  }

  String get description {
    switch (this) {
      case BmiCategory.underweight:
        return 'Indeks massa tubuh Anda di bawah standar ideal (< 18.5).';
      case BmiCategory.normal:
        return 'Hebat! Indeks massa tubuh Anda berada pada rentang yang sangat sehat (18.5 - 24.9).';
      case BmiCategory.overweight:
        return 'Indeks massa tubuh Anda sedikit melebihi batas normal (25.0 - 29.9).';
      case BmiCategory.obese:
        return 'Indeks massa tubuh Anda berada pada tingkat obesitas (≥ 30.0).';
    }
  }

  Color get color {
    switch (this) {
      case BmiCategory.underweight:
        return AppColors.accentAmber;
      case BmiCategory.normal:
        return AppColors.primary;
      case BmiCategory.overweight:
        return AppColors.accentWarm;
      case BmiCategory.obese:
        return AppColors.accentCoral;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case BmiCategory.underweight:
        return AppColors.warmLight;
      case BmiCategory.normal:
        return AppColors.mintLight;
      case BmiCategory.overweight:
        return const Color(0xFFFFF0E6);
      case BmiCategory.obese:
        return const Color(0xFFFFECEB);
    }
  }

  IconData get icon {
    switch (this) {
      case BmiCategory.underweight:
        return Icons.trending_down_rounded;
      case BmiCategory.normal:
        return Icons.verified_rounded;
      case BmiCategory.overweight:
        return Icons.trending_up_rounded;
      case BmiCategory.obese:
        return Icons.warning_amber_rounded;
    }
  }

  List<String> get recommendations {
    switch (this) {
      case BmiCategory.underweight:
        return [
          'Tingkatkan asupan kalori sehat dari alpukat, kacang-kacangan, dan protein tinggi.',
          'Makan dengan porsi teratur 4-5 kali sehari dalam porsi sedang.',
          'Kombinasikan dengan latihan beban ringan untuk membangun massa otot.',
        ];
      case BmiCategory.normal:
        return [
          'Pertahankan pola makan seimbang kaya serat dan buah-buahan segar.',
          'Lakukan aktivitas fisik kardio 150 menit per minggu.',
          'Cukupi kebutuhan hidrasi minimal 2 liter air putih per hari.',
        ];
      case BmiCategory.overweight:
        return [
          'Kurangi konsumsi gula tambahan dan makanan olahan berlebih.',
          'Perbanyak konsumsi buah rendah kalori seperti apel dan jeruk.',
          'Tingkatkan aktivitas jalan kaki harian minimal 7.000 - 10.000 langkah.',
        ];
      case BmiCategory.obese:
        return [
          'Konsultasikan target penurunan berat badan bertahap dengan ahli gizi.',
          'Fokus pada defisit kalori terukur dan gizi padat serat.',
          'Mulai olahraga low-impact seperti berenang atau jalan santai.',
        ];
    }
  }

  static BmiCategory fromBmi(double bmi) {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25.0) return BmiCategory.normal;
    if (bmi < 30.0) return BmiCategory.overweight;
    return BmiCategory.obese;
  }
}

class BmiResult {
  final double score;
  final double weight;
  final double height;
  final BmiCategory category;
  final double idealWeightMin;
  final double idealWeightMax;
  final DateTime calculatedAt;

  const BmiResult({
    required this.score,
    required this.weight,
    required this.height,
    required this.category,
    required this.idealWeightMin,
    required this.idealWeightMax,
    required this.calculatedAt,
  });

  factory BmiResult.calculate({
    required double weightKg,
    required double heightCm,
  }) {
    final heightMeter = heightCm / 100.0;
    final bmi = weightKg / (heightMeter * heightMeter);
    final category = BmiCategory.fromBmi(bmi);
    final minWeight = 18.5 * (heightMeter * heightMeter);
    final maxWeight = 24.9 * (heightMeter * heightMeter);

    return BmiResult(
      score: double.parse(bmi.toStringAsFixed(1)),
      weight: weightKg,
      height: heightCm,
      category: category,
      idealWeightMin: double.parse(minWeight.toStringAsFixed(1)),
      idealWeightMax: double.parse(maxWeight.toStringAsFixed(1)),
      calculatedAt: DateTime.now(),
    );
  }
}
