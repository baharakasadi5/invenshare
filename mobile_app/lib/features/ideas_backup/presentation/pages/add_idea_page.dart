import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/idea_model.dart';
import '../providers/idea_provider.dart';

import '../../../auth/presentation/providers/auth_provider.dart';



class AddIdeaPage extends ConsumerStatefulWidget {

  const AddIdeaPage({
    super.key,
  });


  @override
  ConsumerState<AddIdeaPage> createState() =>
      _AddIdeaPageState();

}




class _AddIdeaPageState
    extends ConsumerState<AddIdeaPage> {


  final titleController =
  TextEditingController();


  final descriptionController =
  TextEditingController();


  final specialtyController =
  TextEditingController();





  Future<void> saveIdea() async {


    if(
    titleController.text.trim().isEmpty ||
        descriptionController.text.trim().isEmpty ||
        specialtyController.text.trim().isEmpty
    ){


      ScaffoldMessenger.of(context)
          .showSnackBar(

        const SnackBar(

          content:

          Text(
            "لطفاً همه اطلاعات را وارد کنید",
          ),

        ),

      );


      return;

    }






    final user =
    ref.read(currentUserProvider);





    final idea = IdeaModel(


      id:

      const Uuid().v4(),



      title:

      titleController.text.trim(),




      description:

      descriptionController.text.trim(),




      specialty:

      specialtyController.text.trim(),




      username:

      user?.username ?? "unknown",




      createdAt:

      DateTime.now(),



    );






    await ref
        .read(
      ideaProvider.notifier,
    )
        .addIdea(
      idea,
    );






    if(!mounted)return;






    ScaffoldMessenger.of(context)
        .showSnackBar(

      const SnackBar(

        content:

        Text(
          "ایده با موفقیت ذخیره شد",
        ),

      ),

    );





    Navigator.pop(context);



  }







  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar:

      AppBar(

        title:

        const Text(
          "ثبت ایده جدید",
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

              titleController,



              decoration:

              const InputDecoration(

                labelText:

                "عنوان ایده",


                prefixIcon:

                Icon(
                  Icons.lightbulb,
                ),

              ),

            ),




            const SizedBox(
              height:15,
            ),




            TextField(

              controller:

              descriptionController,



              maxLines:

              5,



              decoration:

              const InputDecoration(

                labelText:

                "توضیحات ایده",



                prefixIcon:

                Icon(
                  Icons.description,
                ),

              ),

            ),





            const SizedBox(
              height:15,
            ),




            TextField(

              controller:

              specialtyController,



              decoration:

              const InputDecoration(

                labelText:

                "حوزه تخصصی",



                prefixIcon:

                Icon(
                  Icons.category,
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

                saveIdea,



                icon:

                const Icon(
                  Icons.save,
                ),



                label:

                const Text(
                  "ذخیره ایده",
                ),


              ),

            ),



          ],


        ),


      ),
      );


  }







  @override
  void dispose(){


    titleController.dispose();

    descriptionController.dispose();

    specialtyController.dispose();


    super.dispose();


  }



}