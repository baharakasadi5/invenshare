import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../../core/services/backup_service.dart';
import '../../../../core/providers/theme_provider.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/pages/login_page.dart';

import 'language_page.dart';
import 'about_page.dart';
import 'profile_page.dart';


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


    final theme =
    ref.watch(themeProvider);


    final isDark =
        theme == ThemeMode.dark;


    final user =
    ref.watch(currentUserProvider);



    return Scaffold(


      appBar: AppBar(

        title:

        Text(
          l10n.settings,
        ),

        centerTitle: true,

      ),



      body:

      ListView(

        padding:

        const EdgeInsets.all(16),



        children: [



          // Profile


          Card(

            child: ListTile(


              leading:

              CircleAvatar(

                backgroundColor:

                Theme.of(context)
                    .colorScheme
                    .primaryContainer,


                child:

                const Icon(
                  Icons.person,
                ),

              ),



              title:

              Text(
                l10n.profileInventor,
              ),



              subtitle:

              Text(

                user == null

                    ?

                l10n.notLoggedIn

                    :

                user.name.isEmpty

                    ?

                user.username

                    :

                user.name,

              ),



              trailing:

              const Icon(
                Icons.arrow_forward_ios,
              ),



              onTap: (){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const ProfilePage(),

                  ),

                );


              },


            ),

          ),






          const SizedBox(
            height:16,
          ),






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

              Text(
                l10n.languageOptions,
              ),



              trailing:

              const Icon(
                Icons.arrow_forward_ios,
              ),



              onTap: (){


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






          const SizedBox(
            height:16,
          ),






          // Backup


          Card(

            child: ListTile(


              leading:

              const Icon(
                Icons.backup,
              ),



              title:

              Text(
                l10n.backupData,
              ),



              subtitle:

              Text(
                l10n.createBackup,
              ),



              onTap: () async{


                final path =

                await BackupService.createBackup();



                if(context.mounted){


                  ScaffoldMessenger.of(context)
                      .showSnackBar(


                    SnackBar(

                      content:

                      Text(

                        "${l10n.backupCreated}\n$path",

                      ),

                    ),
                    );


                }


              },


            ),

          ),






          const SizedBox(
            height:12,
          ),






          // Restore


          Card(

            child: ListTile(


              leading:

              const Icon(
                Icons.restore,
              ),



              title:

              Text(
                l10n.restoreData,
              ),



              subtitle:

              Text(
                l10n.restoreBackup,
              ),



              onTap: () async{


                await BackupService.restoreBackup();



                if(context.mounted){


                  ScaffoldMessenger.of(context)
                      .showSnackBar(


                    SnackBar(

                      content:

                      Text(

                        l10n.restoreCompleted,

                      ),

                    ),


                  );


                }


              },


            ),

          ),






          const SizedBox(
            height:16,
          ),






          // Theme


          Card(


            child:

            SwitchListTile(



              secondary:

              Icon(

                isDark

                    ?

                Icons.dark_mode

                    :

                Icons.light_mode,

              ),




              title:

              Text(
                l10n.darkMode,
              ),




              subtitle:

              Text(

                isDark

                    ?

                l10n.enabled

                    :

                l10n.disabled,

              ),




              value:

              isDark,




              onChanged: (_) async{


                await ref

                    .read(
                  themeProvider.notifier,
                )

                    .toggleTheme();


              },


            ),


          ),






          const SizedBox(
            height:16,
          ),






          // About


          Card(

            child: ListTile(



              leading:

              const Icon(
                Icons.info_outline,
              ),




              title:

              Text(
                l10n.aboutApp,
              ),




              subtitle:

              Text(
                l10n.versionInfo,
              ),




              trailing:

              const Icon(
                Icons.arrow_forward_ios,
              ),




              onTap: (){


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                    const AboutPage(),

                  ),

                );


              },


            ),

          ),






          const SizedBox(
            height:16,
          ),






          // Logout


          Card(

            child: ListTile(



              leading:

              const Icon(

                Icons.logout,

                color: Colors.red,

              ),




              title:

              Text(
                l10n.logout,
              ),




              subtitle:

              Text(
                l10n.backToLogin,
              ),




              onTap: () async{


                await ref

                    .read(
                  authProvider.notifier,
                )

                    .logout();




                if(context.mounted){


                  Navigator.pushAndRemoveUntil(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>

                      const LoginPage(),

                    ),


                        (route)=>false,

                  );


                }


              },


            ),

          ),



        ],


      ),


    );


  }


}