import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/user_model.dart';
import '../providers/auth_provider.dart';

import 'login_page.dart';


class RegisterPage extends ConsumerStatefulWidget {

  const RegisterPage({
    super.key,
  });


  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();

}



class _RegisterPageState
    extends ConsumerState<RegisterPage> {


  final nameController = TextEditingController();

  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final specialtyController = TextEditingController();

  final bioController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();


  bool loading = false;



  Future<void> register() async {


    final l10n =
    AppLocalizations.of(context)!;



    final password =
    passwordController.text.trim();



    final confirmPassword =
    confirmPasswordController.text.trim();



    if(password != confirmPassword){

      showMessage(
        l10n.passwordMismatch,
      );

      return;

    }



    setState(() {

      loading = true;

    });





    final user = UserModel(

      username:
      usernameController.text.trim(),

      password:
      password,

      name:
      nameController.text.trim(),

      email:
      emailController.text.trim(),

      specialty:
      specialtyController.text.trim(),

      bio:
      bioController.text.trim(),

    );





    final error =
    await ref
        .read(authProvider.notifier)
        .register(user);





    setState(() {

      loading = false;

    });





    final box =
    ref.read(authBoxProvider);



    print("======================");

    print("REGISTER RESULT: $error");

    print("USERS COUNT: ${box.length}");

    print("KEYS: ${box.keys.toList()}");

    print("======================");





    if(error != null){

      showMessage(error);

      return;

    }





    showMessage(
      l10n.registerSuccess,
    );




    Navigator.pushReplacement(

      context,

      MaterialPageRoute(

        builder: (_) =>
        const LoginPage(),

      ),

    );


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



    return Scaffold(


      appBar:

      AppBar(

        title:
        Text(
          l10n.createInventorAccount,
        ),

      ),



      body:

      SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),



        child:

        Column(


          children: [


            TextField(

              controller:
              nameController,

              decoration:

              InputDecoration(

                labelText:
                l10n.fullName,

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:
              usernameController,

              decoration:

              InputDecoration(

                labelText:
                l10n.username,

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:
              emailController,

              decoration:

              InputDecoration(

                labelText:
                l10n.email,

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:
              specialtyController,

              decoration:

              InputDecoration(

                labelText:
                l10n.specialty,

              ),

            ),



            const SizedBox(height:15),
            TextField(

              controller:
              bioController,

              maxLines:3,

              decoration:

              InputDecoration(

                labelText:
                l10n.bio,

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:
              passwordController,

              obscureText:true,

              decoration:

              InputDecoration(

                labelText:
                l10n.password,

              ),

            ),



            const SizedBox(height:15),



            TextField(

              controller:
              confirmPasswordController,

              obscureText:true,

              decoration:

              InputDecoration(

                labelText:
                l10n.confirmPassword,

              ),

            ),



            const SizedBox(height:30),



            FilledButton(

              onPressed:

              loading
                  ?
              null
                  :
              register,



              child:

              loading

                  ?

              const CircularProgressIndicator()

                  :

              Text(
                l10n.register,
              ),


            ),



          ],


        ),


      ),


    );


  }






  @override
  void dispose(){


    nameController.dispose();

    usernameController.dispose();

    emailController.dispose();

    specialtyController.dispose();

    bioController.dispose();

    passwordController.dispose();

    confirmPasswordController.dispose();


    super.dispose();

  }



}