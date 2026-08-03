import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';


final fontProvider =
StateNotifierProvider<FontNotifier,String>((ref){

  return FontNotifier();

});



class FontNotifier extends StateNotifier<String>{


  FontNotifier()
      : super("Vazir"){

    loadFont();

  }



  final box = Hive.box('settings');



  void loadFont(){

    state =
    box.get(
      "font",
      defaultValue: "Vazir",
    );

  }




  Future<void> changeFont(String font) async{


    await box.put(
      "font",
      font,
    );


    state = font;


  }


}