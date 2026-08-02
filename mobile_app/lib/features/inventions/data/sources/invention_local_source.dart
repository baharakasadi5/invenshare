// lib/features/inventions/data/sources/invention_local_source.dart

import 'package:hive/hive.dart';

import '../../domain/entities/invention.dart';


class InventionLocalSource {

  final Box<Invention> box;


  InventionLocalSource(this.box);



  Future<List<Invention>> getInventions() async {

    return box.values.toList();

  }



  Future<void> addInvention(Invention invention) async {

    await box.put(
      invention.id,
      invention,
    );

  }



  Future<void> deleteInvention(String id) async {

    await box.delete(id);

  }



  Future<void> updateInvention(Invention invention) async {

    await box.put(
      invention.id,
      invention,
    );

  }

}