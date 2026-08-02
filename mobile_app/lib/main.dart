// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/inventions/domain/entities/invention.dart';
import 'features/inventions/presentation/pages/inventions_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // مقداردهی اولیه Hive
  await Hive.initFlutter();

  // پاک کردن داده‌های قبلی ناسازگار در محیط ویندوز (فقط برای این اجرا)
 

  // ثبت آداپتور کلاس Invention
  Hive.registerAdapter(InventionAdapter());

  // باز کردن باکس ذخیره‌سازی
  await Hive.openBox<Invention>('inventions');

  runApp(
    const ProviderScope(
      child: InvenShareApp(),
    ),
  );
}

class InvenShareApp extends StatelessWidget {
  const InvenShareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InvenShare',
      debugShowCheckedModeBanner: false,
      
      // تنظیم جهت‌گیری برنامه به صورت راست‌چین برای زبان فارسی
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('fa', 'IR'), // فارسی
      ],
      locale: const Locale('fa', 'IR'),

      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Vazir', // سازگار با فونت وزیر در صورت تعریف در pubspec
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B38B5),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F9FC),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
      ),
      home: const InventionsPage(),
    );
  }
}