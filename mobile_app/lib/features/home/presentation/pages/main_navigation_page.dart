import 'package:flutter/material.dart';

import '../../../inventions/presentation/pages/inventions_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';



class MainNavigationPage extends StatefulWidget {


  const MainNavigationPage({
    super.key,
  });



  @override
  State<MainNavigationPage> createState() =>
      _MainNavigationPageState();


}





class _MainNavigationPageState
    extends State<MainNavigationPage> {



  int currentIndex = 0;




  final pages = const [


    InventionsPage(),


    FavoritesPage(),


  ];





  @override
  Widget build(BuildContext context) {



    return Scaffold(



      body:
      pages[currentIndex],




      bottomNavigationBar:


      NavigationBar(



        selectedIndex:
        currentIndex,



        onDestinationSelected:
            (index){



          setState(() {


            currentIndex = index;


          });


        },



        destinations: const [



          NavigationDestination(

            icon:

            Icon(

              Icons.lightbulb_outline,

            ),

            selectedIcon:

            Icon(

              Icons.lightbulb,

            ),

            label:

            'اختراعات',

          ),






          NavigationDestination(

            icon:

            Icon(

              Icons.favorite_border,

            ),

            selectedIcon:

            Icon(

              Icons.favorite,

              color: Colors.red,

            ),

            label:

            'علاقه‌مندی',

          ),



        ],



      ),



    );



  }



}