// lib/features/inventions/data/repositories/invention_repository_impl.dart

import '../../domain/entities/invention.dart';
import '../../domain/repositories/invention_repository.dart';


class InventionRepositoryImpl implements InventionRepository {


  final List<Invention> _inventions = [];


  @override
  Future<List<Invention>> getInventions() async {
    return _inventions;
  }


  @override
  Future<void> addInvention(Invention invention) async {
    _inventions.add(invention);
  }


  @override
  Future<void> deleteInvention(String id) async {
    _inventions.removeWhere(
      (item) => item.id == id,
    );
  }


  @override
  Future<void> updateInvention(Invention invention) async {

    final index = _inventions.indexWhere(
      (item) => item.id == invention.id,
    );

    if (index != -1) {
      _inventions[index] = invention;
    }

  }

}