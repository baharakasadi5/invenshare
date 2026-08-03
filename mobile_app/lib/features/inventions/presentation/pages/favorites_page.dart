import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../inventions/presentation/providers/invention_provider.dart';
import '../../../inventions/presentation/providers/favorite_provider.dart';
import '../../../inventions/presentation/pages/invention_details_page.dart';


class FavoritesPage extends ConsumerWidget {


  const FavoritesPage({
    super.key,
  });




  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {



    final favoriteIds =
        ref.watch(favoriteProvider);



    final inventions =
        ref.watch(inventionStateProvider);




    final favoriteInventions =
        inventions
            .where(
              (item) =>
              favoriteIds.contains(
                item.id,
              ),
        )
            .toList();






    return Scaffold(



      appBar: AppBar(

        title:
        const Text(
          'علاقه‌مندی‌ها',
        ),

      ),






      body:


      favoriteInventions.isEmpty



          ? const Center(

        child:

        Text(
          'هنوز اختراعی به علاقه‌مندی‌ها اضافه نشده است',
        ),

      )



          : ListView.separated(



        padding:

        const EdgeInsets.all(16),



        itemCount:

        favoriteInventions.length,



        separatorBuilder:

            (_,__) =>

        const SizedBox(
          height:12,
        ),





        itemBuilder:

            (context,index){



          final invention =
          favoriteInventions[index];






          return Card(



            child:

            ListTile(



              leading:

              const CircleAvatar(

                child:

                Icon(

                  Icons.favorite,

                  color: Colors.red,

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

                  Icons.favorite,

                  color: Colors.red,

                ),




                onPressed: () async {



                  await ref

                      .read(

                    favoriteProvider

                        .notifier,

                  )

                      .toggleFavorite(

                    invention.id,

                  );



                },



              ),






              onTap: () {



                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>

                        InventionDetailsPage(

                          invention:

                          invention,

                        ),

                  ),

                );


              },



            ),



          );



        },



      ),




    );



  }



}