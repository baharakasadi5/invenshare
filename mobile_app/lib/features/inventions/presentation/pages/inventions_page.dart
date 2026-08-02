// lib/features/inventions/presentation/pages/inventions_page.dart

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


              separatorBuilder: (context,index) =>
                  const SizedBox(height:12),




              itemBuilder: (context,index){


                final invention =
                    inventions[index];



                return Card(


                  elevation: 1,


                  child: ListTile(



                    onTap: () {


                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) =>

                              InventionDetailsPage(

                                invention: invention,

                              ),

                        ),

                      );


                    },




                    contentPadding:
                    const EdgeInsets.all(16),




                    leading: CircleAvatar(


                      child: const Icon(

                        Icons.lightbulb_outline,

                      ),

                    ),





                    title: Text(


                      invention.title,


                      style: const TextStyle(


                        fontWeight:
                        FontWeight.bold,


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



                      icon: const Icon(

                        Icons.delete_outline,

                      ),



                      onPressed: () async {


                        await ref
                            .read(
                          inventionStateProvider
                              .notifier,
                        )
                            .deleteInvention(

                          invention.id,

                        );


                      },


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



              builder: (context) =>

              const AddInventionPage(),



            ),



          );



        },




        icon: const Icon(

          Icons.add,

        ),




        label: const Text(

          'ثبت اختراع',

        ),



      ),



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



              style: TextStyle(



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



              style: TextStyle(



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