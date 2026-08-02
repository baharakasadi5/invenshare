import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_invention_page.dart';
import 'invention_details_page.dart';
import '../providers/invention_provider.dart';


class InventionsPage extends ConsumerWidget {

  const InventionsPage({
    super.key,
  });


  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {


    final inventions =
        ref.watch(inventionStateProvider);



    return Scaffold(


      appBar: AppBar(

        title: const Text(

          'InvenShare',

          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),

        ),

      ),




      body: inventions.isEmpty


          ? const _EmptyInventionsView()



          : ListView.separated(


              padding: const EdgeInsets.all(16),


              itemCount: inventions.length,


              separatorBuilder: (_, __) =>
                  const SizedBox(height:12),




              itemBuilder: (context,index){


                final invention =
                    inventions[index];



                return Card(


                  elevation: 1,


                  clipBehavior:
                  Clip.antiAlias,



                  child: InkWell(


                    onTap: () {


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (_) =>
                              InventionDetailsPage(

                                invention: invention,

                              ),

                        ),

                      );


                    },



                    child: ListTile(



                      contentPadding:
                      const EdgeInsets.all(16),




                      leading: CircleAvatar(


                        backgroundColor:

                        Theme.of(context)

                            .colorScheme

                            .primaryContainer,



                        child: Icon(

                          Icons.lightbulb_outline,

                          color:

                          Theme.of(context)

                              .colorScheme

                              .primary,

                        ),

                      ),





                      title: Text(


                        invention.title,


                        style:

                        const TextStyle(


                          fontWeight:

                          FontWeight.bold,


                          fontSize:16,


                        ),


                      ),






                      subtitle: Padding(


                        padding:

                        const EdgeInsets.only(

                          top:8,

                        ),



                        child: Text(


                          invention.description,


                          maxLines:2,


                          overflow:

                          TextOverflow.ellipsis,


                        ),


                      ),





                      trailing: IconButton(



                        icon:

                        const Icon(

                          Icons.delete_outline,

                        ),



                        onPressed: () {


                          _showDeleteDialog(

                            context,

                            ref,

                            invention.id,

                          );


                        },



                      ),



                    ),


                  ),



                );


              },


            ),






      floatingActionButton:

      FloatingActionButton.extended(



        onPressed: () {



          Navigator.push(


            context,


            MaterialPageRoute(



              builder: (_) =>

              const AddInventionPage(),



            ),



          );



        },




        icon:
        const Icon(Icons.add),




        label:

        const Text(

          'ثبت اختراع',

        ),



      ),



    );


  }




  void _showDeleteDialog(

      BuildContext context,

      WidgetRef ref,

      String id,

      ) {


    showDialog(

      context: context,

      builder: (context) {


        return AlertDialog(


          title:

          const Text(

            'حذف اختراع',

          ),



          content:

          const Text(

            'آیا مطمئن هستید؟',

          ),



          actions: [


            TextButton(

              onPressed: () {

                Navigator.pop(context);

              },

              child:

              const Text(

                'انصراف',

              ),

            ),




            FilledButton(

              onPressed: () async {


                await ref

                    .read(

                  inventionStateProvider

                      .notifier,

                )

                    .deleteInvention(id);



                if(context.mounted){

                  Navigator.pop(context);

                }


              },

              child:

              const Text(

                'حذف',

              ),

            ),


          ],


        );


      },


    );


  }


}






class _EmptyInventionsView extends StatelessWidget {


  const _EmptyInventionsView();



  @override
  Widget build(BuildContext context) {


    return Center(


      child: Padding(


        padding:

        const EdgeInsets.all(32),



        child: Column(


          mainAxisAlignment:

          MainAxisAlignment.center,



          children: [



            Icon(


              Icons.lightbulb_outline_rounded,


              size:88,


              color:

              Theme.of(context)

                  .colorScheme

                  .primary,


            ),




            const SizedBox(height:20),




            const Text(


              'هنوز اختراعی ثبت نشده است',



              style:

              TextStyle(


                fontSize:20,


                fontWeight:

                FontWeight.bold,


              ),



              textAlign:

              TextAlign.center,


            ),




            const SizedBox(height:8),




            Text(


              'با انتخاب «ثبت اختراع»، اولین ایده یا اختراع خود را به InvenShare اضافه کنید.',



              style:

              TextStyle(


                color:

                Theme.of(context)

                    .colorScheme

                    .onSurfaceVariant,


              ),



              textAlign:

              TextAlign.center,


            ),



          ],



        ),



      ),



    );


  }


}