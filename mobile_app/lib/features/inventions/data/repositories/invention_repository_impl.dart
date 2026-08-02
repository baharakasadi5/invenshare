// lib/features/inventions/data/repositories/invention_repository_impl.dart

import 'package:hive/hive.dart';
import '../../domain/entities/invention.dart';
import '../../domain/repositories/invention_repository.dart';

class InventionRepositoryImpl implements InventionRepository {
  final Box<Invention> _box;

  InventionRepositoryImpl(this._box);

  @override
  Future<List<Invention>> getInventions() async {
    return _box.values.toList();
  }

  @override
  Future<void> addInvention(Invention invention) async {
    await _box.put(invention.id, invention);
  }

  @override
  Future<void> deleteInvention(String id) async {
    await _box.delete(id);
  }
}