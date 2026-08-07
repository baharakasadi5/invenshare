import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../data/models/idea_model.dart';



final ideasBoxProvider =
Provider<Box<IdeaModel>>((ref) {

  return Hive.box<IdeaModel>(
    'ideas',
  );

});





final ideaProvider =

StateNotifierProvider<
    IdeaNotifier,
    List<IdeaModel>
>((ref) {


  final box =
  ref.watch(
    ideasBoxProvider,
  );


  return IdeaNotifier(
    box,
  );


});







class IdeaNotifier
    extends StateNotifier<List<IdeaModel>> {


  final Box<IdeaModel> box;



  IdeaNotifier(
      this.box,
      )
      :
        super([]){

    loadIdeas();

  }







  void loadIdeas(){

    state =
        box.values.toList();

  }







  Future<void> addIdea(
      IdeaModel idea,
      )
  async {


    await box.add(
      idea,
    );


    loadIdeas();


  }







  Future<void> deleteIdea(
      int index,
      )
  async {


    await box.deleteAt(
      index,
    );


    loadIdeas();


  }







  Future<void> updateIdea(
      int index,
      IdeaModel idea,
      )
  async {


    await box.put(
      index,
      idea,
    );


    loadIdeas();


  }







  int get ideaCount {

    return state.length;

  }



}