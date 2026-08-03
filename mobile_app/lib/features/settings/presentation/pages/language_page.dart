// lib/features/settings/presentation/pages/language_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/locale_provider.dart';
import '../../../../l10n/app_localizations.dart';



class LanguagePage extends ConsumerWidget {


  const LanguagePage({
    super.key,
  });




  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {



    final l10n =
        AppLocalizations.of(context)!;



    final currentLocale =
    ref.watch(localeProvider);





    return Scaffold(



      appBar: AppBar(


        title:

        Text(

          l10n.language,

        ),


      ),






      body:

      Padding(


        padding:

        const EdgeInsets.all(20),




        child:

        Column(



          children: [





            Card(



              child:

              ListTile(




                leading:

                const Text(

                  '🇮🇷',

                  style:

                  TextStyle(

                    fontSize:30,

                  ),

                ),





                title:

                const Text(

                  'فارسی',

                ),





                trailing:

                currentLocale.languageCode == 'fa'

                    ?

                const Icon(

                  Icons.check_circle,

                  color: Colors.green,

                )

                    :

                null,







                onTap: () {


                  ref

                      .read(

                    localeProvider.notifier,

                  )

                      .changeLocale(


                    const Locale(

                      'fa',

                      'IR',

                    ),


                  );



                  Navigator.pop(context);


                },



              ),


            ),






            const SizedBox(height:12),






            Card(



              child:

              ListTile(



                leading:

                const Text(

                  '🇺🇸',

                  style:

                  TextStyle(

                    fontSize:30,

                  ),

                ),





                title:

                const Text(

                  'English',

                ),






                trailing:

                currentLocale.languageCode == 'en'

                    ?

                const Icon(

                  Icons.check_circle,

                  color: Colors.green,

                )

                    :

                null,








                onTap: () {


                  ref

                      .read(

                    localeProvider.notifier,

                  )

                      .changeLocale(


                    const Locale(

                      'en',

                      'US',

                    ),


                  );



                  Navigator.pop(context);


                },



              ),


            ),




          ],


        ),


      ),


    );


  }


}