import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';




class ProfilePage extends ConsumerWidget {


  const ProfilePage({
    super.key,
  });





  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {


    final user =
    ref.watch(
      currentUserProvider,
    );





    if(user == null){


      return Scaffold(

        appBar: AppBar(
          title:
          const Text(
              "Profile"
          ),
        ),


        body:
        const Center(

          child:
          Text(
            "No user logged in",
          ),

        ),

      );


    }







    return Scaffold(



      appBar:

      AppBar(

        title:

        const Text(
            "Profile"
        ),

      ),







      body:

      Padding(

        padding:
        const EdgeInsets.all(20),



        child:

        Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,



          children: [






            Center(

              child:

              CircleAvatar(

                radius:
                45,


                child:

                Text(

                  user.username
                      .substring(0,1)
                      .toUpperCase(),


                  style:

                  const TextStyle(

                    fontSize:
                    35,

                    fontWeight:
                    FontWeight.bold,

                  ),

                ),

              ),

            ),







            const SizedBox(
              height:30,
            ),






            profileItem(

              "Username",

              user.username,

              Icons.person,

            ),





            profileItem(

              "Name",

              user.name.isEmpty

                  ? "Not set"

                  : user.name,

              Icons.badge,

            ),





            profileItem(

              "Email",

              user.email.isEmpty

                  ? "Not set"

                  : user.email,

              Icons.email,

            ),





            profileItem(

              "Role",

              user.role,

              Icons.work,

            ),





            profileItem(

              "Created",

              user.createdAt
                  .toString()
                  .substring(0,10),

              Icons.calendar_today,

            ),







            const SizedBox(
              height:30,
            ),






            SizedBox(

              width:
              double.infinity,


              child:

              FilledButton.icon(

                icon:
                const Icon(
                    Icons.lock_reset
                ),



                label:

                const Text(
                    "Change Password"
                ),



                onPressed: (){


                  showChangePasswordDialog(

                    context,

                    ref,

                  );


                },

              ),

            ),






            const SizedBox(
              height:15,
            ),






            SizedBox(

              width:
              double.infinity,


              child:

              FilledButton.icon(

                style:

                FilledButton.styleFrom(

                  backgroundColor:
                  Colors.red,

                ),



                icon:

                const Icon(
                    Icons.delete
                ),



                label:

                const Text(
                    "Delete Account"
                ),



                onPressed: () async{


                  await ref
                      .read(
                    authProvider.notifier,
                  )
                      .deleteAccount();



                  if(context.mounted){

                    Navigator.pop(
                      context,
                    );
                    }



                },

              ),

            ),







          ],


        ),


      ),


    );


  }









  Widget profileItem(

      String title,

      String value,

      IconData icon,

      ){


    return Card(

      child:

      ListTile(

        leading:

        Icon(icon),



        title:

        Text(title),



        subtitle:

        Text(value),


      ),

    );


  }









  void showChangePasswordDialog(

      BuildContext context,

      WidgetRef ref,

      ){



    final controller =
    TextEditingController();




    showDialog(

      context:
      context,

      builder: (_) {


        return AlertDialog(


          title:

          const Text(
              "Change Password"
          ),




          content:

          TextField(

            controller:
            controller,


            obscureText:
            true,


            decoration:

            const InputDecoration(

              labelText:
              "New Password",

            ),

          ),





          actions: [



            TextButton(

              onPressed: (){

                Navigator.pop(
                    context
                );

              },

              child:

              const Text(
                  "Cancel"
              ),

            ),





            FilledButton(

              onPressed: () async{


                final result =

                await ref
                    .read(
                  authProvider.notifier,
                )
                    .updatePassword(
                  controller.text.trim(),
                );



                if(context.mounted){

                  Navigator.pop(
                      context
                  );


                  if(result != null){

                    ScaffoldMessenger.of(context)
                        .showSnackBar(

                      SnackBar(

                        content:
                        Text(result),

                      ),

                    );


                  }

                }



              },


              child:

              const Text(
                  "Save"
              ),


            ),





          ],



        );


      },

    );


  }




}