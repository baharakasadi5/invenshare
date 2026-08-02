// lib/features/inventions/domain/repositories/invention_repository.dart

import '../entities/invention.dart';

abstract class InventionRepository {

  // دریافت همه اختراعات
  Future<List<Invention>> getInventions();

  // اضافه کردن اختراع جدید
  Future<void> addInvention(
    Invention invention,
  );

  // حذف اختراع
  Future<void> deleteInvention(
    String id,
  );

  // ویرایش اختراع
  Future<void> updateInvention(
    Invention invention,
  );
}