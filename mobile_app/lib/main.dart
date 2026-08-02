// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/inventions/domain/entities/invention.dart';

void main() async {
  // اطمینان از مقداردهی اولیه سرویس‌های Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // مقداردهی اولیه Hive
  await Hive.initFlutter();

  // ثبت آداپتور ساخته شده برای کلاس Invention
  Hive.registerAdapter(InventionAdapter());

  // باز کردن باکس اختصاصی برای ذخیره لیست اختراعات
  await Hive.openBox<Invention>('inventions');

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvenShare',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            'InvenShare',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}