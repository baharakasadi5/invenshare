// lib/features/inventions/domain/entities/invention.dart

import 'package:hive/hive.dart';

part 'invention.g.dart';

@HiveType(typeId: 0)
class Invention {

  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;


  // دسته بندی اختراع
  @HiveField(3)
  final String category;


  // نام مخترع
  @HiveField(4)
  final String inventorName;


  // تاریخ ثبت
  @HiveField(5)
  final DateTime createdAt;


  // تحلیل هوش مصنوعی
  @HiveField(6)
  final String aiAnalysis;


  // وضعیت اختراع
  // مثال:
  // draft
  // submitted
  // approved
  @HiveField(7)
  final String status;


  // تصاویر اختراع
  @HiveField(8)
  final List<String> images;



  Invention({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.inventorName,
    required this.createdAt,
    required this.aiAnalysis,
    required this.status,
    required this.images,
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

      description:
          description ?? this.description,

      category:
          category ?? this.category,

      inventorName:
          inventorName ?? this.inventorName,

      createdAt:
          createdAt,

      aiAnalysis:
          aiAnalysis ?? this.aiAnalysis,

      status:
          status ?? this.status,

      images:
          images ?? this.images,

    );

  }

}