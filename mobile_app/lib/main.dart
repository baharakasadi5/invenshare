import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'l10n/app_localizations.dart';

import 'core/providers/locale_provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/providers/font_provider.dart';

import 'core/theme/app_theme.dart';

import 'core/splash/splash_page.dart';

import 'features/inventions/domain/entities/invention.dart';
import 'features/favorites/data/models/favorite_model.dart';
import 'features/auth/domain/entities/user_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // =========================
  // Register Hive Adapters
  // =========================

  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(InventionAdapter());
  }

  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }

  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  // =========================
  // اگر قبلاً برای هماهنگی مدل از این کد استفاده کرده بودی،
  // دیگر آن را اجرا نکن تا اطلاعات کاربران پاک نشوند.
  // =========================

  // if (await Hive.boxExists('users')) {
  //   await Hive.deleteBoxFromDisk('users');
  // }

  // =========================
  // Open Hive Boxes
  // =========================

  await Hive.openBox<Invention>('inventions');

  await Hive.openBox<FavoriteModel>('favorites');

  await Hive.openBox<UserModel>('users');

  await Hive.openBox('settings');

  runApp(
    const ProviderScope(
      child: InvenShareApp(),
    ),
  );
}

class InvenShareApp extends ConsumerWidget {
  const InvenShareApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    final themeMode = ref.watch(themeProvider);
    final font = ref.watch(fontProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'InvenShare',

      locale: locale,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: AppLocalizations.supportedLocales,

      theme: AppTheme.light(font),

      darkTheme: AppTheme.dark(font),

      themeMode: themeMode,

      home: const SplashPage(),
    );
  }
}