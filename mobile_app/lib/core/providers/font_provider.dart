import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



final fontProvider =
StateNotifierProvider<FontNotifier,String>((ref){

  return FontNotifier();

});





class FontNotifier extends StateNotifier<String>{


  FontNotifier()
      : super("Vazirmatn"){

    loadFont();

  }





  final Box box =
  Hive.box(
    'settings',
  );





  void loadFont(){


    final savedFont =
    box.get(
      "font",
      defaultValue: "Vazirmatn",
    );



    state =
        savedFont;


  }







  Future<void> changeFont(
      String font,
      ) async{


    await box.put(
      "font",
      font,
    );



    state =
        font;


  }



}