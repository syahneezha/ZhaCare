import 'package:flutter/material.dart';

/// Palet warna ZhaCare - Mengusung tema "Healthy Minimalist"
/// Kombinasi Hijau Sage & Mint yang menenangkan,
/// latar belakang off-white yang bersih, dan aksen warna hangat.
class AppColors {
  AppColors._();

  // Primary Palette (Hijau Sage & Mint)
  static const Color primary = Color(0xFF5E8B7E);       // Hijau Sage Utama
  static const Color primaryDark = Color(0xFF2F4B3D);   // Sage Gelap (Teks judul/kontras)
  static const Color primaryLight = Color(0xFFA7C4B5);  // Sage Muda
  static const Color mint = Color(0xFFD8E2DC);          // Mint Lembut
  static const Color mintLight = Color(0xFFEAF2EE);     // Background Tint Mint Halus

  // Warm Accents (Aksen Hangat)
  static const Color accentWarm = Color(0xFFF4A261);    // Warm Peach / Apricot
  static const Color accentCoral = Color(0xFFE76F51);   // Coral Hangat
  static const Color accentAmber = Color(0xFFF7B267);   // Soft Amber
  static const Color warmLight = Color(0xFFFFE8D6);     // Tint Hangat

  // Health Metrics Accents
  static const Color calorieAccent = Color(0xFFE67E22); // Oranye Nutrisi & Kalori
  static const Color calorieLight = Color(0xFFFDF2E9);
  static const Color waterAccent = Color(0xFF3A86C8);   // Biru Lembut Hidrasi
  static const Color waterLight = Color(0xFFEBF5FB);
  static const Color fruitAccent = Color(0xFF48A974);   // Hijau Buah
  static const Color fruitLight = Color(0xFFEAF7F0);
  static const Color bmiAccent = Color(0xFF8E7DBE);     // Ungu Pastel BMI
  static const Color bmiLight = Color(0xFFF3F0F9);

  // Neutral & Surfaces (Bersih & Off-white)
  static const Color background = Color(0xFFF7F9F8);    // Latar belakang Off-White
  static const Color surface = Color(0xFFFFFFFF);       // Kartu / Container putih
  static const Color surfaceVariant = Color(0xFFF1F4F2);// Warna elemen sekunder
  static const Color border = Color(0xFFE5EAE7);        // Garis batas halus
  static const Color divider = Color(0xFFEDF1EE);

  // Text Colors
  static const Color textPrimary = Color(0xFF24332C);   // Charcoal Gelap bernuansa herbal
  static const Color textSecondary = Color(0xFF687871); // Abu-abu Muted
  static const Color textLight = Color(0xFF9AA8A1);     // Abu-abu Pudar
  static const Color textOnPrimary = Color(0xFFFFFFFF); // Teks putih pada tombol utama

  // Status & Badges
  static const Color success = Color(0xFF48BB78);
  static const Color warning = Color(0xFFECC94B);
  static const Color error = Color(0xFFE57373);
}
