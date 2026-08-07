import '../../../../l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';
import '../../../auth/presentation/pages/login_page.dart';

import '../../../inventions/presentation/providers/invention_provider.dart';
import '../../../favorites/presentation/providers/favorite_provider.dart';

import '../../../inventions/presentation/pages/add_invention_page.dart';
import '../../../inventions/presentation/pages/inventions_page.dart';

import '../../../settings/presentation/pages/edit_profile_page.dart';
import '../../../settings/presentation/pages/settings_page.dart';


class InventorDashboardPage extends ConsumerWidget {

  const InventorDashboardPage({
    super.key,
  });


  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {

    final l10n = AppLocalizations.of(context)!;


    final user =
    ref.watch(currentUserProvider);


    final inventions =
    ref.watch(inventionStateProvider);


    final favorites =
    ref.watch(favoriteProvider);



    final theme =
    Theme.of(context);

    



    int profileProgress = 0;



    if(user != null){

      if(user.name.isNotEmpty){
        profileProgress += 25;
      }

      if(user.email.isNotEmpty){
        profileProgress += 25;
      }

      if(user.specialty.isNotEmpty){
        profileProgress += 25;
      }

      if(user.bio.isNotEmpty){
        profileProgress += 25;
      }

    }





    return Scaffold(

      body:

      CustomScrollView(

        slivers: [



          SliverAppBar(

            expandedHeight:170,

            pinned:true,



            actions:[


              PopupMenuButton<String>(


                icon:

                const Icon(

                  Icons.more_vert,

                  color: Colors.white,

                ),



                onSelected:(value) async {



                  if(value == "profile"){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>

                        const EditProfilePage(),

                      ),

                    );


                  }





                  if(value == "settings"){


                    Navigator.push(

                      context,

                      MaterialPageRoute(

                        builder:(_)=>

                        const SettingsPage(),

                      ),

                    );


                  }





                  if(value == "logout"){



                    final confirm =

                    await showDialog<bool>(

                      context: context,

                      builder:(context){

                        return AlertDialog(

                          title:

                          const Text(
                            "خروج از حساب",
                          ),


                          content:

                          const Text(
                            "آیا می‌خواهید خارج شوید؟",
                          ),


                          actions:[


                            TextButton(

                              onPressed:(){

                                Navigator.pop(
                                  context,
                                  false,
                                );

                              },

                              child:

                              const Text(
                                "انصراف",
                              ),

                            ),




                            FilledButton(

                              onPressed:(){

                                Navigator.pop(
                                  context,
                                  true,
                                );

                              },

                              child:

                              const Text(
                                "خروج",
                              ),

                            ),



                          ],
                          );

                      },

                    );




                    if(confirm == true){


                      await ref
                          .read(authProvider.notifier)
                          .logout();




                      if(context.mounted){


                        Navigator.pushAndRemoveUntil(

                          context,

                          MaterialPageRoute(

                            builder:(_)=>

                            const LoginPage(),

                          ),

                              (route)=>false,

                        );


                      }


                    }


                  }



                },



                itemBuilder:(context)=>[


                  const PopupMenuItem(

                    value:"profile",

                    child:

                    Text(
                      "پروفایل",
                    ),

                  ),




                  const PopupMenuItem(

                    value:"settings",

                    child:

                    Text(
                      "تنظیمات",
                    ),

                  ),




                  const PopupMenuItem(

                    value:"logout",

                    child:

                    Text(
                      "خروج",
                    ),

                  ),



                ],


              ),



            ],
            flexibleSpace:

            FlexibleSpaceBar(

              title:

              Text(
              l10n.dashboard,
              ),



              background:

              Container(

                decoration:

                BoxDecoration(

                  gradient:

                  LinearGradient(

                    colors:[

                      theme.colorScheme.primary,

                      theme.colorScheme.secondary,

                    ],

                  ),

                ),



                child:

                const Center(

                  child:

                  Icon(

                    Icons.lightbulb,

                    size:70,

                    color:Colors.white,

                  ),

                ),

              ),


            ),


          ),





          SliverPadding(

            padding:

            const EdgeInsets.all(20),



            sliver:


            SliverList(

              delegate:

              SliverChildListDelegate(

                [



                  _profileCard(

                    context,

                    user,

                  ),





                  const SizedBox(

                    height:25,

                  ),





                  Text(

                    l10n.activity,

                    style:

                    theme.textTheme.titleLarge,

                  ),





                  const SizedBox(

                    height:15,

                  ),





                  Row(

                    children:[



                      Expanded(

                        child:

                        _statCard(

                          context,

                          inventions.length.toString(),

                          l10n.inventions,

                          Icons.lightbulb,

                        ),

                      ),





                      const SizedBox(

                        width:12,

                      ),





                      Expanded(

                        child:

                        _statCard(

                          context,

                          favorites.length.toString(),

                          l10n.favorites,

                          Icons.favorite,

                        ),

                      ),



                    ],

                  ),





                  const SizedBox(

                    height:12,

                  ),





                  Row(

                    children:[



                      Expanded(

                        child:

                        _statCard(

                          context,

                          "$profileProgress%",

                          "پیشرفت پروفایل",

                          Icons.trending_up,

                        ),

                      ),



                    ],

                  ),






                  const SizedBox(

                    height:30,

                  ),





                  Text(

                    l10n.quickAccess,

                    style:

                    theme.textTheme.titleLarge,

                  ),





                  const SizedBox(

                    height:15,

                  ),





                  _actionTile(

                    context,

                    title:

                    l10n.addInvention,

                    icon:

                    Icons.add_circle,

                    page:

                    const AddInventionPage(),

                  ),






                  _actionTile(

                    context,

                    title:

                    l10n.myInventions,

                    icon:

                    Icons.list_alt,

                    page:

                    const InventionsPage(),

                  ),






                  _actionTile(

                    context,

                    title:

                    l10n.edit,

                    icon:

                    Icons.person,
                    page:

                    const EditProfilePage(),

                  ),



                ],


              ),


            ),


          ),



        ],


      ),


    );


  }
  Widget _profileCard(
      BuildContext context,
      user,
      ){


    final theme =
    Theme.of(context);



    return Card(

      elevation:3,


      child:

      Padding(

        padding:

        const EdgeInsets.all(20),


        child:

        Column(

          crossAxisAlignment:

          CrossAxisAlignment.start,


          children:[



            Row(

              children:[



                CircleAvatar(

                  radius:30,

                  backgroundColor:

                  theme.colorScheme.primaryContainer,


                  child:

                  const Icon(

                    Icons.person,

                    size:35,

                  ),


                ),




                const SizedBox(

                  width:15,

                ),





                Column(

                  crossAxisAlignment:

                  CrossAxisAlignment.start,


                  children:[



                    Text(

                      user?.name ?? "",

                      style:

                      theme.textTheme.titleLarge,

                    ),





                    Text(

                      user?.specialty ?? "",

                    ),



                  ],


                ),



              ],

            ),



          ],

        ),

      ),


    );


  }









  Widget _statCard(

      BuildContext context,

      String value,

      String title,

      IconData icon,

      ){



    final theme =

    Theme.of(context);



    return Card(



      child:


      Padding(


        padding:

        const EdgeInsets.all(16),



        child:


        Column(


          children:[



            Icon(

              icon,

              color:

              theme.colorScheme.primary,

            ),





            const SizedBox(

              height:10,

            ),






            Text(

              value,

              style:

              theme.textTheme.headlineSmall,

            ),





            Text(

              title,

            ),



          ],



        ),


      ),



    );



  }









  Widget _actionTile(

      BuildContext context,

      {


        required String title,


        required IconData icon,


        required Widget page,


      }

      ){



    return Card(



      child:


      ListTile(



        leading:


        Icon(icon),





        title:


        Text(title),






        trailing:


        const Icon(

          Icons.arrow_forward_ios,

        ),






        onTap:(){



          Navigator.push(



            context,



            MaterialPageRoute(



              builder:(_)=>page,



            ),



          );



        },



      ),



    );



  }



}