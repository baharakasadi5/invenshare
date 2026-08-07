import 'package:hive/hive.dart';

part 'user_model.g.dart';


@HiveType(typeId: 3)
class UserModel {


  @HiveField(0)
  final String username;


  @HiveField(1)
  final String password;


  @HiveField(2)
  final String name;


  @HiveField(3)
  final String email;


  @HiveField(4)
  final String role;


  @HiveField(5)
  final DateTime createdAt;


  // تخصص مخترع
  @HiveField(6)
  final String specialty;


  // معرفی مخترع
  @HiveField(7)
  final String bio;


  // مسیر عکس پروفایل
  @HiveField(8)
  final String profileImage;



  UserModel({

    required this.username,

    required this.password,

    this.name = '',

    this.email = '',

    this.role = 'inventor',

    DateTime? createdAt,

    this.specialty = '',

    this.bio = '',

    this.profileImage = '',

  }) : createdAt = createdAt ?? DateTime.now();





  UserModel copyWith({

    String? username,

    String? password,

    String? name,

    String? email,

    String? role,

    DateTime? createdAt,

    String? specialty,

    String? bio,

    String? profileImage,

  }) {


    return UserModel(

      username:
      username ?? this.username,


      password:
      password ?? this.password,


      name:
      name ?? this.name,


      email:
      email ?? this.email,


      role:
      role ?? this.role,


      createdAt:
      createdAt ?? this.createdAt,


      specialty:
      specialty ?? this.specialty,


      bio:
      bio ?? this.bio,


      profileImage:
      profileImage ?? this.profileImage,

    );


  }





  Map<String, dynamic> toJson(){


    return {

      "username":
      username,


      "password":
      password,


      "name":
      name,


      "email":
      email,


      "role":
      role,


      "createdAt":
      createdAt.toIso8601String(),


      "specialty":
      specialty,


      "bio":
      bio,


      "profileImage":
      profileImage,

    };


  }







  factory UserModel.fromJson(
      Map<String, dynamic> json
      ){


    return UserModel(

      username:
      json['username'] ?? '',


      password:
      json['password'] ?? '',


      name:
      json['name'] ?? '',


      email:
      json['email'] ?? '',


      role:
      json['role'] ?? 'inventor',


      createdAt:

      json['createdAt'] != null

          ?

      DateTime.parse(
        json['createdAt'],
      )

          :

      DateTime.now(),


      specialty:
      json['specialty'] ?? '',


      bio:
      json['bio'] ?? '',


      profileImage:
      json['profileImage'] ?? '',


    );


  }


}