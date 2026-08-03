import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/invention.dart';
import '../providers/invention_provider.dart';


class AddInventionPage extends ConsumerStatefulWidget {

  const AddInventionPage({
    super.key,
  });


  @override
  ConsumerState<AddInventionPage> createState() =>
      _AddInventionPageState();

}




class _AddInventionPageState
    extends ConsumerState<AddInventionPage> {


  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final categoryController = TextEditingController();

  final inventorController = TextEditingController();





  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    categoryController.dispose();

    inventorController.dispose();

    super.dispose();

  }






  Future<void> saveInvention() async {


    final l10n =
    AppLocalizations.of(context)!;




    if(titleController.text.trim().isEmpty){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        SnackBar(

          content:

          Text(

            l10n.enterTitle,

          ),

        ),

      );


      return;

    }







    final invention = Invention(


      id:

      const Uuid().v4(),



      title:

      titleController.text.trim(),




      description:

      descriptionController.text.trim(),




      category:

      categoryController.text.trim().isEmpty

          ? l10n.other

          : categoryController.text.trim(),




      inventorName:

      inventorController.text.trim().isEmpty

          ? l10n.unknown

          : inventorController.text.trim(),




      createdAt:

      DateTime.now(),




      aiAnalysis:

      '',




      status:

      l10n.initialRegistration,




      images:

      [],


    );







    await ref

        .read(

      inventionStateProvider.notifier,

    )

        .addInvention(invention);







    if(mounted){

      Navigator.pop(context);

    }


  }









  Widget buildField({

    required TextEditingController controller,

    required String label,

    required IconData icon,

    int maxLines = 1,

  }){


    return TextField(


      controller: controller,


      maxLines: maxLines,



      decoration: InputDecoration(



        labelText:

        label,



        prefixIcon:

        Icon(icon),




        border:

        OutlineInputBorder(


          borderRadius:

          BorderRadius.circular(16),


        ),



      ),


    );

  }









  @override
  Widget build(BuildContext context) {


    final l10n =
    AppLocalizations.of(context)!;




    return Scaffold(



      appBar: AppBar(


        title:

        Text(

          l10n.addNewInvention,

        ),



      ),






      body:

      SingleChildScrollView(



        padding:

        const EdgeInsets.all(20),



        child:

        Column(



          children: [




            buildField(

              controller:

              titleController,

              label:

              l10n.inventionTitle,

              icon:

              Icons.lightbulb_outline,

            ),






            const SizedBox(height:16),





            buildField(

              controller:

              categoryController,

              label:

              l10n.category,

              icon:

              Icons.category_outlined,

            ),






            const SizedBox(height:16),






            buildField(

              controller:

              inventorController,

              label:

              l10n.inventorName,

              icon:

              Icons.person_outline,

            ),






            const SizedBox(height:16),






            buildField(

              controller:

              descriptionController,

              label:

              l10n.inventionDescription,

              icon:

              Icons.description_outlined,

              maxLines:

              5,

            ),






            const SizedBox(height:30),






            SizedBox(


              width:

              double.infinity,


              height:

              55,




              child:

              FilledButton.icon(



                icon:

                const Icon(

                  Icons.save,

                ),




                label:

                Text(

                  l10n.saveInvention,

                ),




                onPressed:

                saveInvention,



              ),


            ),



          ],


        ),


      ),



    );


  }


}