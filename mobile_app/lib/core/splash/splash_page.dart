import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/home/presentation/pages/main_navigation_page.dart';



class SplashPage extends ConsumerStatefulWidget {


  const SplashPage({
    super.key,
  });



  @override
  ConsumerState<SplashPage> createState() =>
      _SplashPageState();

}




class _SplashPageState
    extends ConsumerState<SplashPage> {


  @override
  void initState() {

    super.initState();


    startApp();

  }





  Future<void> startApp() async {


    await Future.delayed(
      const Duration(
        seconds: 3,
      ),
    );



    if(!mounted) return;



    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const MainNavigationPage(),

      ),

    );


  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      body:

      Container(

        width:
        double.infinity,


        height:
        double.infinity,



        decoration:

        BoxDecoration(


          gradient:

          LinearGradient(


            colors: [

              Theme.of(context)
                  .colorScheme
                  .primary,

              Theme.of(context)
                  .colorScheme
                  .secondary,

            ],


            begin:
            Alignment.topLeft,


            end:
            Alignment.bottomRight,


          ),


        ),





        child:

        Column(


          mainAxisAlignment:
          MainAxisAlignment.center,



          children: [





            Container(

              width:
              120,


              height:
              120,



              decoration:

              BoxDecoration(


                color:
                Colors.white,


                borderRadius:
                BorderRadius.circular(30),


              ),




              child:

              const Icon(

                Icons.lightbulb,


                size:
                70,


                color:
                Colors.deepPurple,

              ),


            ),






            const SizedBox(
              height:30,
            ),





            const Text(

              "InvenShare",


              style:

              TextStyle(


                fontSize:
                36,


                fontWeight:
                FontWeight.bold,


                color:
                Colors.white,


              ),


            ),






            const SizedBox(
              height:15,
            ),





            const Text(

              "Invent • Share • Create",


              style:

              TextStyle(


                fontSize:
                16,


                color:
                Colors.white70,


              ),


            ),





          ],


        ),


      ),


    );


  }


}