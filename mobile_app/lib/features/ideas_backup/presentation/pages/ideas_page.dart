import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/idea_provider.dart';
import 'add_idea_page.dart';



class IdeasPage extends ConsumerWidget {

  const IdeasPage({
    super.key,
  });



  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {



    final ideas =
        ref.watch(ideaProvider);




    return Scaffold(



      appBar:

          AppBar(

        title:

            const Text(
              "ایده‌های من",
            ),

      ),






      floatingActionButton:


          FloatingActionButton(


        child:

            const Icon(
              Icons.add,
            ),



        onPressed: () {



          Navigator.push(


            context,


            MaterialPageRoute(


              builder: (_) =>

                  const AddIdeaPage(),


            ),


          );


        },


      ),








      body:



          ideas.isEmpty



              ?


          const Center(


            child:


                Text(
                  "هنوز ایده‌ای ثبت نشده",
                ),


          )



              :


          ListView.builder(



            itemCount:

                ideas.length,





            itemBuilder:


                (context, index) {



              final idea =

                  ideas[index];







              return Card(



                margin:


                    const EdgeInsets.all(10),





                child:


                    ListTile(



                  title:


                      Text(
                        idea.title,
                      ),






                  subtitle:


                      Text(

                        idea.description.isNotEmpty

                            ? idea.description

                            : "بدون توضیحات",

                      ),






                ),


              );



            },


          ),




    );


  }


}