import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/inventions/domain/entities/invention.dart';
import '../../features/favorites/data/models/favorite_model.dart';



class BackupService {



  static Future<String?> createBackup() async {



    final inventionBox =
    Hive.box<Invention>('inventions');



    final favoriteBox =
    Hive.box<FavoriteModel>('favorites');





    final data = {



      "createdAt":
      DateTime.now()
          .toIso8601String(),





      "inventions":

      inventionBox.values
          .map(
            (item) => item.toJson(),
      )
          .toList(),





      "favorites":

      favoriteBox.values
          .map(
            (item) => item.toJson(),
      )
          .toList(),




    };





    final jsonString =
    jsonEncode(data);





    final directory =
    await getApplicationDocumentsDirectory();





    final file = File(

      '${directory.path}/invenshare_backup.json',

    );





    await file.writeAsString(
      jsonString,
    );




    return file.path;



  }









  static Future<void> restoreBackup() async {



    final result =
    await FilePicker.platform.pickFiles(


      type:
      FileType.custom,


      allowedExtensions:
      [
        'json'
      ],


    );




    if(result == null){
      return;
    }




    final path =
    result.files.single.path;



    if(path == null){
      return;
    }





    final file =
    File(path);





    final content =
    await file.readAsString();





    final data =
    jsonDecode(content);





    final inventionBox =
    Hive.box<Invention>('inventions');



    final favoriteBox =
    Hive.box<FavoriteModel>('favorites');






    await inventionBox.clear();

    await favoriteBox.clear();







    final inventions =
    data["inventions"] ?? [];




    for(final item in inventions){


      final invention =

      Invention.fromJson(

        Map<String,dynamic>.from(item),

      );



      await inventionBox.add(
        invention,
      );


    }







    final favorites =
    data["favorites"] ?? [];





    for(final item in favorites){


      final favorite =

      FavoriteModel.fromJson(

        Map<String,dynamic>.from(item),

      );



      await favoriteBox.add(
        favorite,
      );


    }





  }



}