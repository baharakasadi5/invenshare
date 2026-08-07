import 'package:hive/hive.dart';

part 'idea_model.g.dart';


@HiveType(typeId: 4)
class IdeaModel {


  @HiveField(0)
  final String id;


  @HiveField(1)
  final String title;


  @HiveField(2)
  final String description;


  @HiveField(3)
  final String specialty;


  @HiveField(4)
  final String username;


  @HiveField(5)
  final String status;


  @HiveField(6)
  final DateTime createdAt;




  IdeaModel({

    required this.id,

    required this.title,

    required this.description,

    required this.specialty,

    required this.username,

    this.status = "ایده اولیه",

    DateTime? createdAt,

  }) : createdAt = createdAt ?? DateTime.now();




  IdeaModel copyWith({

    String? id,

    String? title,

    String? description,

    String? specialty,

    String? username,

    String? status,

    DateTime? createdAt,

  }) {


    return IdeaModel(

      id: id ?? this.id,

      title: title ?? this.title,

      description:
      description ?? this.description,

      specialty:
      specialty ?? this.specialty,

      username:
      username ?? this.username,

      status:
      status ?? this.status,

      createdAt:
      createdAt ?? this.createdAt,

    );

  }



}