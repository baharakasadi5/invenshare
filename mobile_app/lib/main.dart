import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'l10n/app_localizations.dart';

import 'core/providers/locale_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/color_provider.dart';
import 'core/providers/font_provider.dart';

import 'core/splash/splash_page.dart';

import 'features/inventions/domain/entities/invention.dart';
import 'features/favorites/data/models/favorite_model.dart';



Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();


  await Hive.initFlutter();



  if (!Hive.isAdapterRegistered(0)) {

    Hive.registerAdapter(
      InventionAdapter(),
    );

  }



  if (!Hive.isAdapterRegistered(1)) {

    Hive.registerAdapter(
      FavoriteModelAdapter(),
    );

  }




  await Hive.openBox<Invention>(
    'inventions',
  );



  await Hive.openBox<FavoriteModel>(
    'favorites',
  );



  await Hive.openBox(
    'settings',
  );




  runApp(

    const ProviderScope(

      child: InvenShareApp(),

    ),

  );


}







class InvenShareApp extends ConsumerWidget {


  const InvenShareApp({
    super.key,
  });



  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {


    final locale =
    ref.watch(localeProvider);



    final themeMode =
    ref.watch(themeProvider);



    final seedColor =
    ref.watch(seedColorProvider);



    final font =
    ref.watch(fontProvider);







    return MaterialApp(



      debugShowCheckedModeBanner:
      false,



      title:
      'InvenShare',





      locale:
      locale,





      localizationsDelegates:
      const [


        AppLocalizations.delegate,


        GlobalMaterialLocalizations.delegate,


        GlobalWidgetsLocalizations.delegate,


        GlobalCupertinoLocalizations.delegate,


      ],





      supportedLocales:
      AppLocalizations.supportedLocales,





      theme:
      createLightTheme(
        seedColor,
        font,
      ),





      darkTheme:
      createDarkTheme(
        seedColor,
        font,
      ),





      themeMode:
      themeMode,





      home:
      const SplashPage(),



    );


  }


}









ThemeData createLightTheme(
    Color seedColor,
    String font,
    ) {



  return ThemeData(



    useMaterial3:
    true,



    fontFamily:
    font,



    colorScheme:
    ColorScheme.fromSeed(



      seedColor:
      seedColor,



      brightness:
      Brightness.light,



    ),





    scaffoldBackgroundColor:
    const Color(
        0xffF8F8FC
    ),





    appBarTheme:
    const AppBarTheme(


      centerTitle:
      true,


      elevation:
      0,


      backgroundColor:
      Colors.transparent,


    ),






    cardTheme:
    CardThemeData(


      elevation:
      2,



      margin:
      const EdgeInsets.symmetric(
        vertical:8,
      ),



      shape:
      RoundedRectangleBorder(


        borderRadius:
        BorderRadius.circular(
          18,
        ),


      ),


    ),






    inputDecorationTheme:
    InputDecorationTheme(



      filled:
      true,



      fillColor:
      Colors.white,



      border:
      OutlineInputBorder(


        borderRadius:
        BorderRadius.circular(
          16,
        ),


        borderSide:
        BorderSide.none,


      ),





      enabledBorder:
      OutlineInputBorder(


        borderRadius:
        BorderRadius.circular(
          16,
        ),


        borderSide:
        BorderSide.none,


      ),





      focusedBorder:
      OutlineInputBorder(


        borderRadius:
        BorderRadius.circular(
          16,
        ),


        borderSide:
        BorderSide(

          color:
          seedColor,

          width:
          2,

        ),


      ),


    ),






    filledButtonTheme:
    FilledButtonThemeData(


      style:
      FilledButton.styleFrom(



        minimumSize:

        const Size(
          double.infinity,
          55,
        ),





        shape:
        RoundedRectangleBorder(


          borderRadius:
          BorderRadius.circular(
            16,
          ),


        ),


      ),


    ),



  );


}









ThemeData createDarkTheme(
    Color seedColor,
    String font,
    ) {



  return ThemeData(



    useMaterial3:
    true,



    fontFamily:
    font,



    colorScheme:
    ColorScheme.fromSeed(



      seedColor:
      seedColor,



      brightness:
      Brightness.dark,



    ),





    scaffoldBackgroundColor:
    const Color(
        0xff121212
    ),





    appBarTheme:
    const AppBarTheme(



      centerTitle:
      true,



      elevation:
      0,



      backgroundColor:
      Colors.transparent,



    ),





    cardTheme:
    CardThemeData(



      elevation:
      3,



      color:
      const Color(
          0xff1E1E1E
      ),





      shape:
      RoundedRectangleBorder(



        borderRadius:
        BorderRadius.circular(
          18,
        ),



      ),



    ),





    inputDecorationTheme:
    InputDecorationTheme(



      filled:
      true,



      fillColor:
      const Color(
          0xff1E1E1E
      ),





      border:
      OutlineInputBorder(



        borderRadius:
        BorderRadius.circular(
          16,
        ),



        borderSide:
        BorderSide.none,



      ),





      enabledBorder:
      OutlineInputBorder(



        borderRadius:
        BorderRadius.circular(
          16,
        ),



        borderSide:
        BorderSide.none,



      ),






      focusedBorder:
      OutlineInputBorder(



        borderRadius:
        BorderRadius.circular(
          16,
        ),



        borderSide:
        BorderSide(



          color:
          seedColor,



          width:
          2,



        ),



      ),




    ),






    filledButtonTheme:
    FilledButtonThemeData(



      style:
      FilledButton.styleFrom(



        minimumSize:
        const Size(
          double.infinity,
          55,
        ),





        shape:
        RoundedRectangleBorder(



          borderRadius:
          BorderRadius.circular(
            16,
          ),



        ),



      ),



    ),



  );


}