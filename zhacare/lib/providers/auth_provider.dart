import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  String _userName = 'Pengguna ZhaCare';
  String _userEmail = '';
  bool _isGuest = false;

  bool get isLoggedIn => _isLoggedIn;
  String get userName => _userName;
  String get userEmail => _userEmail;
  bool get isGuest => _isGuest;

  /// Login dengan email/username & password
  Future<bool> login({
    required String identifier,
    required String password,
  }) async {
    if (identifier.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }

    // Ambil nama tampilan dari identifier atau bagian depan email
    String displayName = identifier.trim();
    if (displayName.contains('@')) {
      displayName = displayName.split('@').first;
      // Kapitalisasi huruf pertama
      if (displayName.isNotEmpty) {
        displayName = displayName[0].toUpperCase() + displayName.substring(1);
      }
    }

    _userName = displayName;
    _userEmail = identifier.contains('@') ? identifier.trim() : '$displayName@zhacare.com';
    _isLoggedIn = true;
    _isGuest = false;
    notifyListeners();
    return true;
  }

  /// Registrasi akun baru
  Future<bool> register({
    required String name,
    required String email,
    required String password,
  }) async {
    if (name.trim().isEmpty || email.trim().isEmpty || password.trim().isEmpty) {
      return false;
    }

    _userName = name.trim();
    _userEmail = email.trim();
    _isLoggedIn = true;
    _isGuest = false;
    notifyListeners();
    return true;
  }

  /// Masuk instan sebagai Tamu tanpa registrasi
  void loginAsGuest() {
    _userName = 'Sobat ZhaCare';
    _userEmail = 'tamu@zhacare.local';
    _isLoggedIn = true;
    _isGuest = true;
    notifyListeners();
  }

  /// Keluar / Logout dari aplikasi
  void logout() {
    _isLoggedIn = false;
    _userName = 'Pengguna ZhaCare';
    _userEmail = '';
    _isGuest = false;
    notifyListeners();
  }
}
