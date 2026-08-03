import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'add_invention_page.dart';
import 'invention_details_page.dart';

import '../providers/invention_provider.dart';
import '../providers/invention_filter_provider.dart';


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
        ref.watch(filteredInventionsProvider);



    final allInventions =
        ref.watch(inventionStateProvider);



    final categories = {

      'همه',

      ...allInventions
          .map((e) => e.category)
          .where((e) => e.isNotEmpty),

    }.toList();



    final selectedCategory =
        ref.watch(inventionCategoryProvider);



    return Scaffold(


      appBar: AppBar(

        title: const Text(

          'InvenShare',

          style: TextStyle(

            fontWeight: FontWeight.bold,

          ),

        ),

      ),




      body: Column(


        children: [



          Padding(

            padding:
            const EdgeInsets.all(16),


            child: Column(

              children: [



                TextField(


                  decoration:

                  InputDecoration(


                    hintText:

                    'جستجوی اختراع...',



                    prefixIcon:

                    const Icon(

                      Icons.search,

                    ),




                    border:

                    OutlineInputBorder(

                      borderRadius:

                      BorderRadius.circular(16),

                    ),


                  ),



                  onChanged: (value){


                    ref

                        .read(

                      inventionSearchProvider

                          .notifier,

                    )

                        .state = value;


                  },


                ),




                const SizedBox(height:12),




                DropdownButtonFormField<String>(


                  value: selectedCategory,


                  decoration:

                  InputDecoration(


                    labelText:

                    'دسته‌بندی',



                    border:

                    OutlineInputBorder(

                      borderRadius:

                      BorderRadius.circular(16),

                    ),


                  ),



                  items:

                  categories

                      .map(

                          (category) =>

                          DropdownMenuItem(

                            value: category,

                            child:

                            Text(category),

                          )

                  )

                      .toList(),




                  onChanged: (value){


                    if(value != null){


                      ref

                          .read(

                        inventionCategoryProvider

                            .notifier,

                      )

                          .state = value;


                    }


                  },


                ),



              ],

            ),

          ),





          Expanded(



            child: inventions.isEmpty



                ? const _EmptyInventionsView()




                : ListView.separated(



              padding:

              const EdgeInsets.symmetric(

                horizontal:16,

              ),




              itemCount:

              inventions.length,




              separatorBuilder: (_,__)=>

              const SizedBox(

                height:12,

              ),





              itemBuilder:

                  (context,index){



                final invention =

                inventions[index];





                return Card(



                  elevation:1,



                  clipBehavior:

                  Clip.antiAlias,
                  child: InkWell(



                    onTap: (){


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




                      leading:

                      CircleAvatar(


                        child:

                        const Icon(

                          Icons.lightbulb_outline,

                        ),


                      ),





                      title:

                      Text(

                        invention.title,

                        style:

                        const TextStyle(

                          fontWeight:

                          FontWeight.bold,

                        ),

                      ),





                      subtitle:

                      Text(

                        invention.description,

                        maxLines:2,

                        overflow:

                        TextOverflow.ellipsis,

                      ),




                      trailing:

                      IconButton(



                        icon:

                        const Icon(

                          Icons.delete_outline,

                        ),




                        onPressed: (){


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



          ),



        ],


      ),





      floatingActionButton:

      FloatingActionButton.extended(



        onPressed: (){


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

      ){



    showDialog(


      context: context,


      builder: (_) => AlertDialog(



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

            onPressed: (){

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



      ),


    );


  }



}






class _EmptyInventionsView extends StatelessWidget {


  const _EmptyInventionsView();



  @override
  Widget build(BuildContext context) {


    return Center(


      child:

      Text(

        'اختراعی پیدا نشد',

        style:

        Theme.of(context)

            .textTheme

            .titleLarge,

      ),


    );


  }


}