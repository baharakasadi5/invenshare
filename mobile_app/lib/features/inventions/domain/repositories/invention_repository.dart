// lib/features/inventions/domain/repositories/invention_repository.dart

import '../entities/invention.dart';

abstract class InventionRepository {
  Future<List<Invention>> getInventions();
  Future<void> addInvention(Invention invention);
  Future<void> deleteInvention(String id);
}