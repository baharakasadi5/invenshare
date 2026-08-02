// lib/features/inventions/presentation/pages/add_invention_page.dart


import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

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



  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    super.dispose();

  }



  Future<void> saveInvention() async {


    if(titleController.text.trim().isEmpty){

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'لطفاً عنوان اختراع را وارد کنید',
          ),
        ),
      );

      return;
    }



    final invention = Invention(

      id: const Uuid().v4(),

      title: titleController.text.trim(),

      description:
      descriptionController.text.trim(),

      createdAt: DateTime.now(),

    );



    await ref
        .read(inventionStateProvider.notifier)
        .addInvention(invention);



    if(mounted){

      Navigator.pop(context);

    }

  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          'ثبت اختراع جدید',
        ),

      ),



      body: Padding(

        padding: const EdgeInsets.all(20),


        child: Column(

          children: [


            TextField(

              controller: titleController,

              decoration: InputDecoration(

                labelText: 'عنوان اختراع',

                prefixIcon:
                const Icon(
                  Icons.lightbulb_outline,
                ),

                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(16),

                ),

              ),

            ),



            const SizedBox(height:20),




            TextField(

              controller: descriptionController,

              maxLines:5,


              decoration: InputDecoration(

                labelText:
                'توضیحات اختراع',

                alignLabelWithHint:true,


                prefixIcon:
                const Icon(
                  Icons.description_outlined,
                ),


                border:
                OutlineInputBorder(

                  borderRadius:
                  BorderRadius.circular(16),

                ),

              ),

            ),



            const SizedBox(height:30),




            SizedBox(

              width:double.infinity,


              height:55,


              child: FilledButton.icon(


                icon:
                const Icon(
                  Icons.save,
                ),


                label:
                const Text(
                  'ذخیره اختراع',
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