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

  @HiveField(3)
  final DateTime createdAt;

  Invention({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}