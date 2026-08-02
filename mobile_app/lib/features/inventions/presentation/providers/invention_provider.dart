// lib/features/inventions/presentation/providers/invention_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../domain/entities/invention.dart';
import '../../domain/repositories/invention_repository.dart';
import '../../data/repositories/invention_repository_impl.dart';

// ۱. پرووایدر برای دسترسی به باکس باز شده‌ی Hive
final inventionsBoxProvider = Provider<Box<Invention>>((ref) {
  return Hive.box<Invention>('inventions');
});

// ۲. پرووایدر برای دسترسی به Repository پیاده‌سازی شده
final inventionRepositoryProvider = Provider<InventionRepository>((ref) {
  final box = ref.watch(inventionsBoxProvider);
  return InventionRepositoryImpl(box);
});

// ۳. کنترل‌کننده وضعیت (Notifier) برای مدیریت لیست اختراعات
class InventionNotifier extends StateNotifier<List<Invention>> {
  final InventionRepository _repository;

  InventionNotifier(this._repository) : super([]) {
    _loadInventions();
  }

  // لود کردن لیست اختراعات ذخیره‌شده از ریپازیتوری
  Future<void> _loadInventions() async {
    state = await _repository.getInventions();
  }

  // اضافه کردن اختراع جدید و به‌روزرسانی وضعیت
  Future<void> addInvention(Invention invention) async {
    await _repository.addInvention(invention);
    state = [...state, invention];
  }

  // حذف اختراع و به‌روزرسانی وضعیت
  Future<void> deleteInvention(String id) async {
    await _repository.deleteInvention(id);
    state = state.where((item) => item.id != id).toList();
  }
}

// ۴. پرووایدر سراسری برای کنترل وضعیت که رابط کاربری به آن وصل می‌شود
final inventionStateProvider = StateNotifierProvider<InventionNotifier, List<Invention>>((ref) {
  final repository = ref.watch(inventionRepositoryProvider);
  return InventionNotifier(repository);
});