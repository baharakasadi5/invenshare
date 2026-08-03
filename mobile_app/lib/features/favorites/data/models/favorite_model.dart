import 'package:hive/hive.dart';

part 'favorite_model.g.dart';


@HiveType(typeId: 2)
class FavoriteModel extends HiveObject {


  @HiveField(0)
  final String inventionId;



  FavoriteModel({

    required this.inventionId,

  });


}