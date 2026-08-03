import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

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


    final l10n = AppLocalizations.of(context)!;


    final inventions =
        ref.watch(filteredInventionsProvider);


    final allInventions =
        ref.watch(inventionStateProvider);



    final categories = <String>[

      l10n.all,

      ...allInventions
          .map((e) => e.category)
          .where((e) => e.isNotEmpty)
          .toSet(),

    ];



    final selectedCategory =
        ref.watch(inventionCategoryProvider);



    final safeSelectedCategory =
    categories.contains(selectedCategory)
        ? selectedCategory
        : l10n.all;




    return Scaffold(


      appBar: AppBar(


        title: Text(

          l10n.appTitle,

          style: const TextStyle(

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

                    l10n.searchInventions,


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
                      inventionSearchProvider.notifier,
                    )

                        .state = value;


                  },


                ),




                const SizedBox(height:12),






                DropdownButtonFormField<String>(


                  value:

                  safeSelectedCategory,



                  decoration:

                  InputDecoration(


                    labelText:

                    l10n.category,


                    border:

                    OutlineInputBorder(

                      borderRadius:

                      BorderRadius.circular(16),

                    ),

                  ),




                  items:

                  categories.map(

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
                        inventionCategoryProvider.notifier,
                      )

                          .state = value;


                    }


                  },


                ),



              ],

            ),

          ),






          Expanded(


            child:

            inventions.isEmpty


                ?

            _EmptyInventionsView(

              text: l10n.noInventionFound,

            )



                :

            ListView.separated(



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



                  child:

                  InkWell(



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




                    child:

                    ListTile(



                      contentPadding:

                      const EdgeInsets.all(16),




                      leading:

                      const CircleAvatar(


                        child:

                        Icon(

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

        Text(

          l10n.addInvention,

        ),



      ),



    );


  }







  void _showDeleteDialog(

      BuildContext context,

      WidgetRef ref,

      String id,

      ){



    final l10n =
    AppLocalizations.of(context)!;



    showDialog(


      context: context,


      builder: (_) => AlertDialog(



        title:

        Text(

          l10n.deleteInvention,

        ),




        content:

        Text(

          l10n.deleteConfirm,

        ),




        actions: [



          TextButton(

            onPressed: (){

              Navigator.pop(context);

            },

            child:

            Text(

              l10n.cancel,

            ),

          ),





          FilledButton(


            onPressed: () async {



              await ref

                  .read(
                inventionStateProvider.notifier,
              )

                  .deleteInvention(id);




              if(context.mounted){

                Navigator.pop(context);

              }


            },


            child:

            Text(

              l10n.delete,

            ),



          ),



        ],



      ),


    );


  }



}







class _EmptyInventionsView extends StatelessWidget {


  final String text;


  const _EmptyInventionsView({

    required this.text,

  });

  @override
  Widget build(BuildContext context) {


    return Center(


      child:

      Text(

        text,


        style:

        Theme.of(context)

            .textTheme

            .titleLarge,

      ),


    );


  }


}