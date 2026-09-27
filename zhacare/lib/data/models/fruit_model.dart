import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';

class FruitNutritions {
  final double calories;
  final double fat;
  final double sugar;
  final double carbohydrates;
  final double protein;

  const FruitNutritions({
    required this.calories,
    required this.fat,
    required this.sugar,
    required this.carbohydrates,
    required this.protein,
  });

  factory FruitNutritions.fromJson(Map<String, dynamic> json) {
    return FruitNutritions(
      calories: _parseDouble(json['calories']),
      fat: _parseDouble(json['fat']),
      sugar: _parseDouble(json['sugar']),
      carbohydrates: _parseDouble(json['carbohydrates']),
      protein: _parseDouble(json['protein']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0.0;
  }
}

class FruitModel {
  final int id;
  final String name;
  final String family;
  final String order;
  final String genus;
  final FruitNutritions nutritions;

  const FruitModel({
    required this.id,
    required this.name,
    required this.family,
    required this.order,
    required this.genus,
    required this.nutritions,
  });

  factory FruitModel.fromJson(Map<String, dynamic> json) {
    return FruitModel(
      id: json['id'] is int ? json['id'] as int : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] as String? ?? 'Buah Segar',
      family: json['family'] as String? ?? 'Umum',
      order: json['order'] as String? ?? '-',
      genus: json['genus'] as String? ?? '-',
      nutritions: json['nutritions'] != null
          ? FruitNutritions.fromJson(json['nutritions'] as Map<String, dynamic>)
          : const FruitNutritions(calories: 0, fat: 0, sugar: 0, carbohydrates: 0, protein: 0),
    );
  }

  /// Terjemahan nama Indonesia untuk buah-buah umum
  String get indonesianName {
    final map = {
      'apple': 'Apel',
      'banana': 'Pisang',
      'orange': 'Jeruk',
      'strawberry': 'Stroberi',
      'watermelon': 'Semangka',
      'mango': 'Mangga',
      'pineapple': 'Nanas',
      'grape': 'Anggur',
      'avocado': 'Alpukat',
      'kiwi': 'Kiwi',
      'papaya': 'Pepaya',
      'guava': 'Jambu Biji',
      'peach': 'Persik',
      'lemon': 'Lemon',
      'lime': 'Jeruk Nipis',
      'blueberry': 'Blueberry',
      'raspberry': 'Raspberry',
      'blackberry': 'Blackberry',
      'cherry': 'Ceri',
      'pear': 'Pir',
      'melon': 'Melon',
      'fig': 'Tin / Buah Ara',
      'pomegranate': 'Delima',
      'dragonfruit': 'Buah Naga',
      'passionfruit': 'Markisa',
      'plum': 'Plum',
      'apricot': 'Aprikot',
      'coconut': 'Kelapa',
      'durian': 'Durian',
    };
    return map[name.toLowerCase()] ?? name;
  }

  /// Kategori kepadatan kalori
  String get calorieCategory {
    if (nutritions.calories < 50) return 'Rendah Kalori';
    if (nutritions.calories <= 90) return 'Kalori Sedang';
    return 'Padat Energi';
  }

  Color get categoryColor {
    if (nutritions.calories < 50) return AppColors.fruitAccent;
    if (nutritions.calories <= 90) return AppColors.accentAmber;
    return AppColors.accentCoral;
  }

  Color get categoryBgColor {
    if (nutritions.calories < 50) return AppColors.fruitLight;
    if (nutritions.calories <= 90) return AppColors.warmLight;
    return const Color(0xFFFFECEB);
  }
}
