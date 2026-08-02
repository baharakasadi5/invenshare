// lib/features/inventions/presentation/providers/invention_provider.dart


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';


import '../../domain/entities/invention.dart';
import '../../domain/repositories/invention_repository.dart';

import '../../data/repositories/invention_repository_impl.dart';
import '../../data/sources/invention_local_source.dart';





// Hive Box Provider

final inventionsBoxProvider =
Provider<Box<Invention>>((ref) {

  return Hive.box<Invention>(
    'inventions',
  );

});






// Local Data Source Provider

final inventionLocalSourceProvider =
Provider<InventionLocalSource>((ref) {


  final box =
      ref.watch(inventionsBoxProvider);



  return InventionLocalSource(
    box,
  );


});







// Repository Provider

final inventionRepositoryProvider =
Provider<InventionRepository>((ref) {


  final localSource =
      ref.watch(
        inventionLocalSourceProvider,
      );



  return InventionRepositoryImpl(
    localSource,
  );


});









// State Controller

class InventionNotifier
    extends StateNotifier<List<Invention>> {



  final InventionRepository repository;




  InventionNotifier(
    this.repository,
  ) : super([]) {

    loadInventions();

  }







  Future<void> loadInventions() async {


    try {


      final result =
          await repository.getInventions();



      state = result;



    } catch (e) {


      state = [];

    }


  }








  Future<void> addInvention(
    Invention invention,
  ) async {



    await repository.addInvention(
      invention,
    );



    state = [

      ...state,

      invention,

    ];


  }









  Future<void> deleteInvention(
    String id,
  ) async {


    await repository.deleteInvention(
      id,
    );



    state = state
        .where(
          (item) => item.id != id,
        )
        .toList();



  }









  Future<void> updateInvention(
    Invention invention,
  ) async {



    await repository.updateInvention(
      invention,
    );



    state = state.map(
      (item) {


        if(item.id == invention.id){

          return invention;

        }


        return item;


      },

    ).toList();



  }









  Future<void> refresh() async {


    await loadInventions();


  }



}









// Main Provider

final inventionStateProvider =
StateNotifierProvider<
    InventionNotifier,
    List<Invention>
>((ref) {


  final repository =
      ref.watch(
        inventionRepositoryProvider,
      );



  return InventionNotifier(
    repository,
  );


});