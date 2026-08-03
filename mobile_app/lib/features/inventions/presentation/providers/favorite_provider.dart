import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../favorites/data/models/favorite_model.dart';



final favoriteProvider =
    StateNotifierProvider<FavoriteNotifier, List<String>>(
  (ref) {

    return FavoriteNotifier();

  },
);





class FavoriteNotifier extends StateNotifier<List<String>> {


  FavoriteNotifier()
      : super([]) {

    loadFavorites();

  }



  final Box<FavoriteModel> box =
      Hive.box<FavoriteModel>('favorites');





  void loadFavorites() {


    state = box.values

        .map(

          (favorite) =>

              favorite.inventionId,

        )

        .toList();


  }






  bool isFavorite(String inventionId) {


    return state.contains(
      inventionId,
    );


  }







  Future<void> toggleFavorite(
      String inventionId,
      ) async {



    if (isFavorite(inventionId)) {


      final favorite =

          box.values.firstWhere(

                (item) =>

            item.inventionId == inventionId,

          );



      await favorite.delete();



      state = [

        ...state,

      ]..remove(inventionId);



    } else {



      await box.add(

        FavoriteModel(

          inventionId: inventionId,

        ),

      );



      state = [

        ...state,

        inventionId,

      ];


    }


  }


}