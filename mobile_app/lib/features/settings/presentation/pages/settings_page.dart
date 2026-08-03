import '../../../../core/services/backup_service.dart';
import 'about_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../../core/providers/theme_provider.dart';
import '../../../../core/providers/font_provider.dart';
import '../../../../core/providers/color_provider.dart';

import 'language_page.dart';



class SettingsPage extends ConsumerWidget {


  const SettingsPage({
    super.key,
  });



  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {


    final l10n =
    AppLocalizations.of(context)!;



    final currentTheme =
    ref.watch(themeProvider);



    final isDark =
        currentTheme == ThemeMode.dark;



    final currentSeedColor =
    ref.watch(seedColorProvider);



    final currentFont =
    ref.watch(fontProvider);





    final colors = [

      const Color(0xFF5B38B5),

      Colors.blue,

      Colors.green,

      Colors.orange,

      Colors.red,

      Colors.teal,

    ];





    final fonts = [

      "Vazir",

      "Roboto",

      "Arial",

    ];







    return Scaffold(



      appBar: AppBar(

        title:

        Text(

          l10n.settings,

        ),

      ),





      body: ListView(



        padding:

        const EdgeInsets.all(16),



        children: [





          // Language


          Card(

            child: ListTile(

              leading:

              const Icon(
                Icons.language,
              ),



              title:

              Text(
                l10n.language,
              ),



              subtitle:

              const Text(
                'فارسی / English',
              ),



              trailing:

              const Icon(
                Icons.arrow_forward_ios,
              ),



              onTap: () {


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const LanguagePage(),

                  ),

                );


              },


            ),

          ),

          const SizedBox(height: 16),

// Backup
Card(
  child: ListTile(
    leading: const Icon(Icons.backup),
    title: const Text("Backup Data"),
    subtitle: const Text("Create backup of all inventions"),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () async {
      final path = await BackupService.createBackup();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Backup created:\n$path",
            ),
          ),
        );
      }
    },
  ),
),

const SizedBox(height: 12),

// Restore
Card(
  child: ListTile(
    leading: const Icon(Icons.restore),
    title: const Text("Restore Data"),
    subtitle: const Text("Restore backup file"),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () async {
      await BackupService.restoreBackup();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Restore completed",
            ),
          ),
        );
      }
    },
  ),
),
        
const SizedBox(height: 16),


          const SizedBox(height:16),







          // Dark Mode


          Card(

            child: SwitchListTile(


              secondary:

              Icon(

                isDark

                    ? Icons.dark_mode

                    : Icons.light_mode,

              ),



              title:

              Text(
                l10n.darkMode,
              ),



              subtitle:

              Text(

                isDark

                    ? l10n.enabled

                    : l10n.disabled,

              ),



              value:

              isDark,



              onChanged: (value){


                ref

                    .read(themeProvider.notifier)

                    .toggleTheme();


              },


            ),

          ),








          const SizedBox(height:16),







          // Seed Color


          Card(


            child: Padding(


              padding:

              const EdgeInsets.all(16),



              child: Column(


                crossAxisAlignment:

                CrossAxisAlignment.start,



                children: [



                  const Text(

                    'رنگ اصلی برنامه',

                    style:

                    TextStyle(

                      fontSize:18,

                      fontWeight:

                      FontWeight.bold,

                    ),

                  ),





                  const SizedBox(height:16),





                  Wrap(


                    spacing:

                    14,


                    children:

                    colors.map((color){



                      final selected =

                      color.value ==

                          currentSeedColor.value;





                      return GestureDetector(



                        onTap: (){


                          ref

                              .read(

                            seedColorProvider.notifier,
                            )

                              .changeColor(

                            color,

                          );


                        },




                        child: Container(



                          width:

                          45,



                          height:

                          45,



                          decoration:

                          BoxDecoration(



                            color:

                            color,



                            shape:

                            BoxShape.circle,



                            border:

                            selected

                                ?

                            Border.all(

                              width:4,

                              color:

                              Theme.of(context)

                                  .colorScheme

                                  .onSurface,

                            )

                                :

                            null,


                          ),



                        ),



                      );




                    }).toList(),



                  ),



                ],



              ),



            ),



          ),







          const SizedBox(height:16),







          // Font Selector


          Card(


            child: Column(


              children: [



                ListTile(


                  leading:

                  const Icon(

                    Icons.font_download,

                  ),



                  title:

                  const Text(

                    'فونت برنامه',

                  ),



                  subtitle:

                  Text(

                    currentFont,

                  ),



                ),





                ...fonts.map((font){


                  return RadioListTile<String>(


                    title:

                    Text(

                      font,

                      style:

                      TextStyle(

                        fontFamily:

                        font,

                      ),

                    ),



                    value:

                    font,



                    groupValue:

                    currentFont,



                    onChanged:

                    (value){



                      if(value != null){


                        ref

                            .read(

                          fontProvider.notifier,

                        )

                            .changeFont(

                          value,

                        );


                      }



                    },


                  );



                }),



              ],


            ),



          ),


// About
Card(
  child: ListTile(
    leading: const Icon(Icons.info_outline),
    title: const Text("About"),
    subtitle: const Text("Version 1.0.0"),
    trailing: const Icon(Icons.arrow_forward_ios),
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const AboutPage(),
        ),
      );
    },
  ),
),


        ],



      ),



    );


  }


}