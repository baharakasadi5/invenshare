// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/inventions/domain/entities/invention.dart';
import 'features/favorites/data/models/favorite_model.dart';

import 'features/inventions/presentation/pages/inventions_page.dart';



Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();



  // Initialize Hive
  await Hive.initFlutter();




  // Register Invention Adapter

  if (!Hive.isAdapterRegistered(0)) {

    Hive.registerAdapter(
      InventionAdapter(),
    );

  }




  // Register Favorite Adapter

  if (!Hive.isAdapterRegistered(1)) {

    Hive.registerAdapter(
      FavoriteModelAdapter(),
    );

  }





  // Open Hive Boxes


  await Hive.openBox<Invention>(
    'inventions',
  );



  await Hive.openBox<FavoriteModel>(
    'favorites',
  );





  runApp(

    const ProviderScope(

      child: InvenShareApp(),

    ),

  );

}





class InvenShareApp extends StatelessWidget {


  const InvenShareApp({
    super.key,
  });



  @override
  Widget build(BuildContext context) {


    return MaterialApp(


      title: 'InvenShare',



      debugShowCheckedModeBanner: false,




      localizationsDelegates: const [

        GlobalMaterialLocalizations.delegate,

        GlobalWidgetsLocalizations.delegate,

        GlobalCupertinoLocalizations.delegate,

      ],




      supportedLocales: const [

        Locale('fa','IR'),

        Locale('en','US'),

      ],




      locale: const Locale(
        'fa',
        'IR',
      ),




      theme: ThemeData(


        useMaterial3: true,



        fontFamily: 'Vazir',




        colorScheme: ColorScheme.fromSeed(


          seedColor:
          Color(0xFF5B38B5),


          brightness:
          Brightness.light,


        ),




        scaffoldBackgroundColor:

        const Color(0xFFF9F9FC),




        appBarTheme:

        const AppBarTheme(


          centerTitle: false,


          elevation: 0,


          backgroundColor:
          Colors.transparent,


        ),



      ),




      home:

      const InventionsPage(),



    );


  }


}