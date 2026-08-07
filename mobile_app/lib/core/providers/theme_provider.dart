import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



final themeProvider =
StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {

  return ThemeNotifier();

});





class ThemeNotifier extends StateNotifier<ThemeMode> {


  ThemeNotifier()
      : super(ThemeMode.light) {

    _loadTheme();

  }





  final Box box =
  Hive.box(
    'settings',
  );








  void _loadTheme() {


    final savedTheme =
    box.get(
      'themeMode',
      defaultValue: 'light',
    );




    if(savedTheme == 'dark'){


      state = ThemeMode.dark;


    }else{


      state = ThemeMode.light;


    }


  }









  Future<void> toggleTheme() async {



    if(state == ThemeMode.light){


      state = ThemeMode.dark;



      await box.put(
        'themeMode',
        'dark',
      );



    }
    else{


      state = ThemeMode.light;



      await box.put(
        'themeMode',
        'light',
      );



    }



  }








  Future<void> changeTheme(
      ThemeMode mode,
      ) async {



    state = mode;



    await box.put(

      'themeMode',

      mode == ThemeMode.dark
          ? 'dark'
          : 'light',

    );



  }





}