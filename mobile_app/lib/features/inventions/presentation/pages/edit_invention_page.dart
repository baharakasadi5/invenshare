// lib/features/inventions/presentation/pages/edit_invention_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/invention.dart';
import '../providers/invention_provider.dart';


class EditInventionPage extends ConsumerStatefulWidget {

  final Invention invention;


  const EditInventionPage({
    super.key,
    required this.invention,
  });



  @override
  ConsumerState<EditInventionPage> createState() =>
      _EditInventionPageState();

}



class _EditInventionPageState
    extends ConsumerState<EditInventionPage> {


  late TextEditingController titleController;

  late TextEditingController descriptionController;

  late TextEditingController categoryController;

  late TextEditingController inventorController;

  late TextEditingController statusController;

  late TextEditingController aiController;



  @override
  void initState() {

    super.initState();


    final invention = widget.invention;


    titleController =
        TextEditingController(text: invention.title);


    descriptionController =
        TextEditingController(text: invention.description);


    categoryController =
        TextEditingController(text: invention.category);


    inventorController =
        TextEditingController(text: invention.inventorName);


    statusController =
        TextEditingController(text: invention.status);


    aiController =
        TextEditingController(text: invention.aiAnalysis);

  }




  @override
  void dispose() {

    titleController.dispose();

    descriptionController.dispose();

    categoryController.dispose();

    inventorController.dispose();

    statusController.dispose();

    aiController.dispose();


    super.dispose();

  }




  Future<void> saveChanges() async {


    final updatedInvention =
        widget.invention.copyWith(


          title: titleController.text.trim(),


          description:
          descriptionController.text.trim(),


          category:
          categoryController.text.trim(),


          inventorName:
          inventorController.text.trim(),


          status:
          statusController.text.trim(),


          aiAnalysis:
          aiController.text.trim(),


        );



    await ref
        .read(inventionStateProvider.notifier)
        .updateInvention(
          updatedInvention,
        );



    if(mounted){

      Navigator.pop(context);

    }


  }





  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          'ویرایش اختراع',
        ),

      ),




      body: SingleChildScrollView(


        padding:
        const EdgeInsets.all(20),



        child: Column(


          children: [



            _field(
              controller: titleController,
              label: 'عنوان اختراع',
              icon: Icons.lightbulb_outline,
            ),



            _field(
              controller: descriptionController,
              label: 'توضیحات',
              icon: Icons.description_outlined,
              maxLines: 5,
            ),



            _field(
              controller: categoryController,
              label: 'دسته‌بندی',
              icon: Icons.category_outlined,
            ),



            _field(
              controller: inventorController,
              label: 'نام مخترع',
              icon: Icons.person_outline,
            ),



            _field(
              controller: statusController,
              label: 'وضعیت',
              icon: Icons.info_outline,
            ),



            _field(
              controller: aiController,
              label: 'تحلیل هوش مصنوعی',
              icon: Icons.auto_awesome,
              maxLines: 4,
            ),




            const SizedBox(height:25),




            SizedBox(

              width: double.infinity,

              height:55,


              child: FilledButton.icon(


                icon: const Icon(
                  Icons.save,
                ),
                 label: const Text(
                  'ذخیره تغییرات',
                ),



                onPressed:
                saveChanges,


              ),

            ),



          ],


        ),


      ),


    );


  }





  Widget _field({

    required TextEditingController controller,

    required String label,

    required IconData icon,

    int maxLines = 1,

  }) {


    return Padding(

      padding:
      const EdgeInsets.only(bottom:15),


      child: TextField(


        controller: controller,


        maxLines: maxLines,


        decoration: InputDecoration(


          labelText: label,


          prefixIcon:
          Icon(icon),


          border:
          OutlineInputBorder(

            borderRadius:
            BorderRadius.circular(16),

          ),

        ),

      ),

    );


  }


}