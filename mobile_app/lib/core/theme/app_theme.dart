import 'package:flutter/material.dart';


class AppTheme {


  static const Color primary =
      Color(0xff6C4FF8);


  static const Color secondary =
      Color(0xff00AEEF);



  static const Color lightBackground =
      Color(0xffF8FAFC);



  static const Color darkBackground =
      Color(0xff0F172A);






  static ThemeData light(String font) {


    return ThemeData(


      useMaterial3: true,


      fontFamily: font,



      brightness:
      Brightness.light,



      colorScheme:

      ColorScheme.fromSeed(

        seedColor:
        primary,

        brightness:
        Brightness.light,

      ),





      scaffoldBackgroundColor:
      lightBackground,





      textTheme:

      const TextTheme(

        headlineSmall:

        TextStyle(

          fontSize:24,

          fontWeight:
          FontWeight.bold,

        ),



        titleLarge:

        TextStyle(

          fontSize:18,

          fontWeight:
          FontWeight.bold,

        ),



        bodyMedium:

        TextStyle(

          fontSize:14,

        ),


      ),






      appBarTheme:

      const AppBarTheme(


        centerTitle:true,


        elevation:0,


        backgroundColor:
        Colors.transparent,


        foregroundColor:
        Color(0xff111827),


      ),






      cardTheme:

      CardThemeData(


        elevation:2,


        color:
        Colors.white,



        margin:

        const EdgeInsets.symmetric(

          vertical:8,

        ),



        shape:

        RoundedRectangleBorder(

          borderRadius:

          BorderRadius.all(

            Radius.circular(20),

          ),

        ),


      ),







      inputDecorationTheme:

      InputDecorationTheme(



        filled:true,



        fillColor:
        Colors.white,



        contentPadding:

        const EdgeInsets.symmetric(

          horizontal:18,

          vertical:16,

        ),





        border:

        OutlineInputBorder(


          borderRadius:

          BorderRadius.circular(16),


          borderSide:
          BorderSide.none,


        ),






        focusedBorder:

        OutlineInputBorder(


          borderRadius:

          BorderRadius.circular(16),



          borderSide:

          const BorderSide(

            color:
            primary,

            width:2,

          ),


        ),


      ),








      filledButtonTheme:

      FilledButtonThemeData(


        style:

        FilledButton.styleFrom(


          backgroundColor:
          primary,


          foregroundColor:
          Colors.white,



          minimumSize:

          const Size(

            double.infinity,

            55,

          ),




          shape:

          RoundedRectangleBorder(

            borderRadius:

            BorderRadius.circular(16),

          ),


        ),


      ),




    );


  }









  static ThemeData dark(String font) {



    return ThemeData(



      useMaterial3:true,



      fontFamily:
      font,



      brightness:
      Brightness.dark,





      colorScheme:

      ColorScheme.fromSeed(


        seedColor:
        const Color(0xffA78BFA),



        brightness:

        Brightness.dark,


      ),






      scaffoldBackgroundColor:

      darkBackground,






      textTheme:

      const TextTheme(


        headlineSmall:

        TextStyle(

          fontSize:24,

          fontWeight:
          FontWeight.bold,

        ),



        titleLarge:

        TextStyle(

          fontSize:18,

          fontWeight:
          FontWeight.bold,

        ),



      ),







      cardTheme:

      CardThemeData(



        elevation:4,



        color:

        const Color(0xff1E293B),




        shape:

        RoundedRectangleBorder(

          borderRadius:

          BorderRadius.circular(20),


        ),


      ),







      inputDecorationTheme:

      InputDecorationTheme(



        filled:true,



        fillColor:

        const Color(0xff1E293B),






        border:

        OutlineInputBorder(



          borderRadius:

          BorderRadius.circular(16),



          borderSide:

          BorderSide.none,


        ),



      ),







      filledButtonTheme:

      FilledButtonThemeData(



        style:

        FilledButton.styleFrom(



          backgroundColor:

          const Color(0xffA78BFA),



          foregroundColor:

          Colors.black,




          minimumSize:

          const Size(

            double.infinity,

            55,

          ),



          shape:

          RoundedRectangleBorder(

            borderRadius:

            BorderRadius.circular(16),


          ),



        ),


      ),





    );

  }



}