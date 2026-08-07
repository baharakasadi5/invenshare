import '../../../../l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/auth_provider.dart';


class EditProfilePage extends ConsumerStatefulWidget {

  const EditProfilePage({
    super.key,
  });


  @override
  ConsumerState<EditProfilePage> createState() =>
      _EditProfilePageState();

}





class _EditProfilePageState
    extends ConsumerState<EditProfilePage> {


  late TextEditingController nameController;

  late TextEditingController emailController;

  late TextEditingController specialtyController;

  late TextEditingController bioController;





  @override
  void initState() {

    super.initState();


    final user =
    ref.read(currentUserProvider);



    nameController =
        TextEditingController(
          text: user?.name ?? '',
        );


    emailController =
        TextEditingController(
          text: user?.email ?? '',
        );


    specialtyController =
        TextEditingController(
          text: user?.specialty ?? '',
        );


    bioController =
        TextEditingController(
          text: user?.bio ?? '',
        );


  }
  @override
  void dispose() {


    nameController.dispose();

    emailController.dispose();

    specialtyController.dispose();

    bioController.dispose();


    super.dispose();

  }








  Future<void> saveProfile() async {


    final l10n =
    AppLocalizations.of(context)!;



    final user =
    ref.read(currentUserProvider);



    if(user == null){

      return;

    }






    final updatedUser =
    user.copyWith(


      name:
      nameController.text.trim(),



      email:
      emailController.text.trim(),



      specialty:
      specialtyController.text.trim(),



      bio:
      bioController.text.trim(),


    );







    await ref
        .read(authProvider.notifier)
        .updateProfile(
      updatedUser,
    );







    if(mounted){


      ScaffoldMessenger.of(context)
          .showSnackBar(


        SnackBar(

          content:

          Text(
            l10n.profileSaved,
          ),

        ),


      );



      Navigator.pop(context);


    }


  }









  @override
  Widget build(
      BuildContext context
      ) {


    //final theme =
    Theme.of(context);


    final l10n =
    AppLocalizations.of(context)!;
    return Scaffold(



      appBar:

      AppBar(

        title:

        Text(
          l10n.editProfile,
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
                l10n.name,

                prefixIcon:
                const Icon(
                  Icons.person,
                ),

              ),

            ),







            const SizedBox(
              height:16,
            ),








            TextField(

              controller:
              emailController,


              keyboardType:
              TextInputType.emailAddress,


              decoration:

              InputDecoration(

                labelText:
                l10n.email,

                prefixIcon:
                const Icon(
                  Icons.email,
                ),

              ),

            ),







            const SizedBox(
              height:16,
            ),







            TextField(

              controller:
              specialtyController,


              decoration:

              InputDecoration(

                labelText:
                l10n.specialty,


                hintText:
                l10n.specialtyHint,


                prefixIcon:
                const Icon(
                  Icons.engineering,
                ),

              ),

            ),







            const SizedBox(
              height:16,
            ),







            TextField(

              controller:
              bioController,


              maxLines:
              5,


              decoration:

              InputDecoration(

                labelText:
                l10n.bio,


                hintText:
                l10n.bioHint,


                prefixIcon:
                const Icon(
                  Icons.description,
                ),

              ),

            ),








            const SizedBox(
              height:30,
            ),








            SizedBox(

              width:
              double.infinity,


              child:

              FilledButton.icon(


                onPressed:
                saveProfile,


                icon:

                const Icon(
                  Icons.save,
                ),



                label:

                Text(
                  l10n.save,
                ),


              ),

            ),




          ],


        ),


      ),


    );


  }


}