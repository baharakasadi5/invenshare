import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../../core/providers/version_provider.dart';


class AboutPage extends ConsumerWidget {


  const AboutPage({
    super.key,
  });



  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {


    final l10n =
    AppLocalizations.of(context)!;



    final version =
    ref.watch(versionProvider);




    return Scaffold(



      appBar: AppBar(


        title:

        Text(

          l10n.about,

        ),


      ),






      body:

      SingleChildScrollView(


        padding:

        const EdgeInsets.all(20),



        child:

        Column(



          children: [





            const SizedBox(height:30),






            CircleAvatar(


              radius:

              45,



              backgroundColor:

              Theme.of(context)

                  .colorScheme

                  .primary,



              child:

              const Icon(

                Icons.lightbulb,

                size:50,

                color:Colors.white,

              ),



            ),






            const SizedBox(height:20),





            Text(


              "InvenShare",


              style:

              Theme.of(context)

                  .textTheme

                  .headlineSmall

                  ?.copyWith(


                fontWeight:

                FontWeight.bold,


              ),


            ),






            const SizedBox(height:10),





            Text(


              l10n.appDescription,



              textAlign:

              TextAlign.center,


            ),






            const SizedBox(height:30),








            Card(


              child:

              ListTile(



                leading:

                const Icon(

                  Icons.info_outline,

                ),




                title:

                Text(

                  l10n.version,

                ),




                subtitle:

                version.when(



                  data: (value) =>

                      Text(value),



                  loading: () =>

                  const Text(

                    "Loading...",

                  ),




                  error: (context, error) =>

                  const Text(

                    "Unknown",

                  ),



                ),



              ),



            ),







            Card(


              child:

              ListTile(



                leading:

                const Icon(

                  Icons.code,

                ),




                title:

                Text(

                  l10n.technology,

                ),




                subtitle:

                const Text(

                  "Flutter + Riverpod + Hive",

                ),



              ),



            ),








            Card(


              child:

              ListTile(



                leading:

                const Icon(

                  Icons.person,

                ),




                title:

                Text(

                  l10n.developer,

                ),




                subtitle:

                const Text(

                  "InvenShare Team",

                ),



              ),



            ),



          ],



        ),



      ),



    );



  }



}