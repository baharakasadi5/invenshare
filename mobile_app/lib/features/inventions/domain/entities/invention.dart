import 'package:hive/hive.dart';

part 'invention.g.dart';

@HiveType(typeId: 0)
class Invention {

  // قبلی
  @HiveField(0)
  final String id;


  @HiveField(1)
  final String title;


  @HiveField(2)
  final String description;


  // قبلی HiveField 3 بود
  @HiveField(3)
  final DateTime createdAt;


  // فیلدهای جدید
  @HiveField(4)
  final String category;


  @HiveField(5)
  final String inventorName;


  @HiveField(6)
  final String aiAnalysis;


  @HiveField(7)
  final String status;


  @HiveField(8)
  final List<String> images;



  Invention({

    required this.id,

    required this.title,

    required this.description,

    required this.createdAt,

    this.category = 'عمومی',

    this.inventorName = 'نامشخص',

    this.aiAnalysis = '',

    this.status = 'draft',

    this.images = const [],

  });



  Invention copyWith({

    String? title,

    String? description,

    String? category,

    String? inventorName,

    String? aiAnalysis,

    String? status,

    List<String>? images,

  }) {


    return Invention(

      id: id,

      title: title ?? this.title,

      description: description ?? this.description,

      createdAt: createdAt,

      category: category ?? this.category,

      inventorName:
          inventorName ?? this.inventorName,

      aiAnalysis:
          aiAnalysis ?? this.aiAnalysis,

      status:
          status ?? this.status,

      images:
          images ?? this.images,

    );

  }

}