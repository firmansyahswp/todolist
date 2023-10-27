import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:todolist/controller/animation_controller.dart';
import 'package:todolist/controller/data_controller.dart';
import 'package:todolist/pages/home_page.dart';
import 'package:todolist/provider/menu_item_provider.dart';
import 'package:todolist/provider/theme_provider.dart';

void main() { //memulai aplikasi
  runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<MenuItemProvider>( // untuk state menu item
            create: (contex) => MenuItemProvider()),
        ChangeNotifierProvider<ThemeProvider>( //untuk state Tema aplikasi
            create: (contex) => ThemeProvider()..setThemeFromLocal()),
      ],
      builder: (context, _) {
        return MyApp();
      }));
}

class MyApp extends StatelessWidget { // menu utama aplikasi
  MyApp({Key? key}) : super(key: key);
	final getAnimationController = Get.put(GetAnimationController()); //kontroler animasi menggunakan GetX.
	final dataController = Get.put(DataController()); //menginisialisasi kontroler data menggunakan GetX.
	@override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GetMaterialApp(
      title: 'TO DO LIST UTS', // judul aplikasi
      themeMode: themeProvider.themeMode, // tema
      darkTheme: MyTheme.darkTheme, //tema dark
      theme: MyTheme.lightTheme, // tema light
      home: const HomePage(), //bagian home
    );
  }
}
