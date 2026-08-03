import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../inventions/presentation/pages/inventions_page.dart';
import '../../../favorites/presentation/pages/favorites_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';





class MainNavigationPage extends ConsumerStatefulWidget {


  const MainNavigationPage({
    super.key,
  });



  @override
  ConsumerState<MainNavigationPage> createState() =>
      _MainNavigationPageState();


}






class _MainNavigationPageState
    extends ConsumerState<MainNavigationPage> {



  int currentIndex = 0;






  final pages = const [


    InventionsPage(),


    FavoritesPage(),


    SettingsPage(),


  ];








  @override
  Widget build(BuildContext context) {



    final l10n =
        AppLocalizations.of(context)!;





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





        destinations: [





          NavigationDestination(



            icon:

            const Icon(

              Icons.lightbulb_outline,

            ),




            selectedIcon:

            const Icon(

              Icons.lightbulb,

            ),




            label:

            l10n.myInventions,



          ),








          NavigationDestination(



            icon:

            const Icon(

              Icons.favorite_border,

            ),




            selectedIcon:

            const Icon(

              Icons.favorite,

              color: Colors.red,

            ),




            label:

            l10n.favorites,



          ),







          NavigationDestination(



            icon:

            const Icon(

              Icons.settings_outlined,

            ),




            selectedIcon:

            const Icon(

              Icons.settings,

            ),




            label:

            l10n.settings,



          ),





        ],




      ),




    );



  }




}