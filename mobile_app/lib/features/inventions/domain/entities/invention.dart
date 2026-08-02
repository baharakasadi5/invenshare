// lib/features/inventions/domain/entities/invention.dart

class Invention {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;

  Invention({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });
}