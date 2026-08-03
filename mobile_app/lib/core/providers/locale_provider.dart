import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';



final localeProvider =
StateNotifierProvider<LocaleNotifier, Locale>((ref) {

  return LocaleNotifier();

});






class LocaleNotifier extends StateNotifier<Locale> {


  LocaleNotifier()
      : super(
    const Locale(
      'fa',
      'IR',
    ),
  ) {

    loadLocale();

  }





  final Box box =
  Hive.box(
    'settings',
  );






  void loadLocale() {


    final language =
    box.get(
      'language',
      defaultValue: 'fa',
    );



    if(language == 'en') {


      state =
      const Locale(
        'en',
        'US',
      );


    } else {


      state =
      const Locale(
        'fa',
        'IR',
      );


    }


  }







  Future<void> changeLocale(
      Locale locale,
      ) async {



    await box.put(
      'language',
      locale.languageCode,
    );



    state = locale;


  }


}