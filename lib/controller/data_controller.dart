import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataController extends GetxController{ //turunan dari GetXController, yang digunakan untuk mengelola state aplikasi.

  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>(); //mengontrol animasi saat menghapus atau menambahkan 
  List<Map<String, dynamic>> nameList = [];
  final textController = TextEditingController(); //Input Text
	
	void getLocalData() async { //Mengammbil dan menyimpan data dari lokal SharedPreferences
    final pref = await SharedPreferences.getInstance();
    final String? getData = pref.getString('data');
    if (getData != null) {
      List<dynamic> dataTemp = jsonDecode(getData);
      for (int i = dataTemp.length - 1; i >= 0; i--) {
        addDataToNameList(i, dataTemp[i]['name'], dataTemp[i]['isChecked']);
      }
    }
  }

  void addDataToNameList(int id, String name, bool isChecked) { // menambahkan data ke nameList
    nameList.insert(0, {'id': id, 'name': name, 'isChecked': isChecked});
    key.currentState!.insertItem(0, duration: const Duration(milliseconds: 100));
  }

	void setLocalData() async { //menyimpan data dalam penyimpanan lokal (SharedPreferences). Daftar nameList
    final pref = await SharedPreferences.getInstance();
    String setData = json.encode(nameList);
    pref.setString('data', setData);
  }

	void removeLocalData() async { //menghapus data lokal dengan menghapus kunci 'data' dari SharedPreferences.
    final pref = await SharedPreferences.getInstance();
    pref.remove('data');
  }

  void addNameList() { //menambahkan entri kosong ke dalam nameList
    textController.clear();
    nameList.insert(0, {'id': 0, 'name': '', 'isChecked': false});
    key.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 800));
  }

  void removeItem(int index) { //Hapus elemen dari nameList dan animasikan penghapusan.
    key.currentState!.removeItem(
      index,
      (_, animation) {
        return SizeTransition(
          sizeFactor: animation,
        );
      },
    );
    nameList.removeAt(index); 
    setLocalData();
  }
@override
  void onInit() { // inisialisasi dan mengambil data dari penyimpanan lokal.
		getLocalData();
    super.onInit();
  }
}
