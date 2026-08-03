import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



final themeProvider =
StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {

  return ThemeNotifier();

});






class ThemeNotifier extends StateNotifier<ThemeMode> {


  ThemeNotifier()
      : super(
    ThemeMode.light,
  ) {

    loadTheme();

  }





  final Box box =
  Hive.box(
    'settings',
  );







  void loadTheme() {


    final isDark =
    box.get(
      'darkMode',
      defaultValue: false,
    );



    state =
    isDark

        ? ThemeMode.dark

        : ThemeMode.light;


  }









  Future<void> changeTheme(
      ThemeMode mode,
      ) async {



    final isDark =
        mode == ThemeMode.dark;




    await box.put(

      'darkMode',

      isDark,

    );





    state = mode;



  }









  Future<void> toggleTheme() async {



    final newTheme =

    state == ThemeMode.dark

        ? ThemeMode.light

        : ThemeMode.dark;





    await changeTheme(
      newTheme,
    );



  }





}