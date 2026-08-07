import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../providers/auth_provider.dart';

import 'register_page.dart';

import '../../../home/presentation/pages/inventor_dashboard_page.dart';


class LoginPage extends ConsumerStatefulWidget {

  const LoginPage({
    super.key,
  });


  @override
  ConsumerState<LoginPage> createState() =>
      _LoginPageState();

}




class _LoginPageState
    extends ConsumerState<LoginPage> {


  final usernameController =
      TextEditingController();


  final passwordController =
      TextEditingController();



  bool loading = false;





  Future<void> login() async {


    final l10n =
        AppLocalizations.of(context)!;


    final username =
        usernameController.text.trim();


    final password =
        passwordController.text.trim();





    if (username.isEmpty || password.isEmpty) {


      showMessage(
        l10n.loginRequired,
      );


      return;

    }






    setState(() {

      loading = true;

    });







    final success =

    await ref
        .read(authProvider.notifier)
        .login(

      username,

      password,

    );





    if (!mounted) return;





    setState(() {

      loading = false;

    });







    if(success){


      Navigator.pushReplacement(

        context,

        MaterialPageRoute(

          builder: (_) =>

          const InventorDashboardPage(),

        ),

      );


    }else{


      showMessage(

        l10n.invalidLogin,

      );


    }


  }








  void showMessage(String message){


    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        content:

        Text(message),

      ),

    );


  }








  @override
  Widget build(BuildContext context) {


    final l10n =
        AppLocalizations.of(context)!;


    final user =
        ref.watch(currentUserProvider);





    return Scaffold(


      appBar:

      AppBar(

        title:

        Text(

          l10n.loginToApp,

        ),

      ),







      body:

      Center(


        child:

        SingleChildScrollView(


          padding:

          const EdgeInsets.all(20),





          child:


          Card(


            elevation: 8,


            child:


            Padding(


              padding:

              const EdgeInsets.all(25),





              child:


              Column(


                mainAxisSize:

                MainAxisSize.min,



                children: [






                  CircleAvatar(


                    radius: 50,



                    backgroundColor:

                    Colors.deepPurple,



                    backgroundImage:

                    user != null &&
                        user.profileImage.isNotEmpty

                        ?

                    FileImage(

                      File(

                        user.profileImage,

                      ),

                    )

                        :

                    null,



                    child:

                    user == null || user.profileImage.isEmpty

                        ?

                    const Icon(

                      Icons.person,

                      size:60,

                      color:Colors.white,

                    )

                        :

                    null,



                  ),







                  const SizedBox(

                    height:15,

                  ),







                  if(user != null)

                    Text(

                      user.username,

                      style:

                      Theme.of(context)
                          .textTheme
                          .titleLarge,

                    ),







                  const SizedBox(

                    height:25,

                  ),







                  TextField(


                    controller:

                    usernameController,
                    decoration:

                    InputDecoration(

                      labelText:

                      l10n.username,


                      prefixIcon:

                      const Icon(

                        Icons.person,

                      ),


                      border:

                      const OutlineInputBorder(),

                    ),


                  ),








                  const SizedBox(

                    height:15,

                  ),







                  TextField(


                    controller:

                    passwordController,



                    obscureText:

                    true,



                    decoration:

                    InputDecoration(

                      labelText:

                      l10n.password,


                      prefixIcon:

                      const Icon(

                        Icons.lock,

                      ),



                      border:

                      const OutlineInputBorder(),

                    ),


                  ),







                  const SizedBox(

                    height:30,

                  ),







                  SizedBox(

                    width:

                    double.infinity,



                    child:


                    FilledButton(


                      onPressed:

                      loading

                          ?

                      null

                          :

                      login,



                      child:

                      loading


                          ?

                      const SizedBox(

                        height:22,

                        width:22,

                        child:

                        CircularProgressIndicator(),

                      )


                          :


                      Text(

                        l10n.login,

                      ),


                    ),

                  ),







                  TextButton(


                    onPressed:


                    (){


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>

                          const RegisterPage(),

                        ),

                      );


                    },



                    child:


                    Text(

                      l10n.noAccountRegister,

                    ),


                  ),





                ],

              ),

            ),

          ),


        ),

      ),

    );


  }








  @override
  void dispose(){


    usernameController.dispose();


    passwordController.dispose();


    super.dispose();


  }


}