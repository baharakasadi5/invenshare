import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



final seedColorProvider =
StateNotifierProvider<SeedColorNotifier, Color>((ref) {

  return SeedColorNotifier();

});





class SeedColorNotifier extends StateNotifier<Color> {


  SeedColorNotifier()
      : super(
    const Color(0xFF5B38B5),
  ) {

    loadColor();

  }





  final Box box =
  Hive.box(
    'settings',
  );





  void loadColor() {


    final colorValue =
    box.get(
      'seedColor',
      defaultValue: 0xFF5B38B5,
    );



    state =
        Color(colorValue);



  }






  Future<void> changeColor(
      Color color,
      ) async {


    await box.put(

      'seedColor',

      color.value,

    );



    state = color;


  }



}