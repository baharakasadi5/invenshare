// lib/features/inventions/data/sources/invention_local_source.dart

import 'package:hive/hive.dart';

import '../../domain/entities/invention.dart';



class InventionLocalSource {


  final Box<Invention> box;



  InventionLocalSource(
    this.box,
  );



  Future<List<Invention>> getInventions() async {

    try {

      return box.values.toList();

    } catch (e) {

      throw Exception(
        'خطا در خواندن اختراعات: $e',
      );

    }

  }



  Future<void> addInvention(
    Invention invention,
  ) async {

    try {

      await box.put(
        invention.id,
        invention,
      );


      await box.flush();


    } catch (e) {

      throw Exception(
        'خطا در ذخیره اختراع: $e',
      );

    }

  }



  Future<void> deleteInvention(
    String id,
  ) async {

    try {

      await box.delete(id);


      await box.flush();


    } catch (e) {

      throw Exception(
        'خطا در حذف اختراع: $e',
      );

    }

  }



  Future<void> updateInvention(
    Invention invention,
  ) async {

    try {

      await box.put(
        invention.id,
        invention,
      );


      await box.flush();


    } catch (e) {

      throw Exception(
        'خطا در ویرایش اختراع: $e',
      );

    }

  }

}