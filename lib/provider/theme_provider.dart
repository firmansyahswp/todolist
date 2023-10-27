import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier { //kelas untuk mengelola tema aplikasi
  ThemeMode themeMode = ThemeMode.dark; //untuk menyimpan tema, dengan default tema gelap

  setThemeFromLocal() async { //mengambil dan menerapkan preferensi tema dari shared preferences.
    final pref = await SharedPreferences.getInstance();
    bool isDark = pref.getBool('isDark') ?? false;
    toggleTheme(isDark); //toggle untuk mengubah tema
  }

  bool get isDarkMode => themeMode == ThemeMode.dark; // tema gelap

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light; //  tema terang
    notifyListeners();
  }
}

class MyTheme { //class yang mendefinisikan tema
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.dark(),
      primaryColor: const Color.fromRGBO(25, 25, 25, 1),
      iconTheme:const IconThemeData(color: Color.fromARGB(255, 116, 18, 165), opacity: 1),
      secondaryHeaderColor: Colors.white,
      fontFamily: 'Poppins'
		);

  static final lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      colorScheme: const ColorScheme.light(),
      primaryColor: Colors.white,
      iconTheme: const IconThemeData(color: Color.fromARGB(255, 63, 3, 131), opacity: 1),
      secondaryHeaderColor: Colors.grey[700],
      fontFamily: 'Poppins'
		);
}
