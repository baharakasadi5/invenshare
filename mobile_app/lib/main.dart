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
import 'features/ideas_backup/data/models/idea_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // =========================
  // Initialize Hive
  // =========================

  await Hive.initFlutter();

  // =========================
  // Register Hive Adapters
  // =========================

  // Invention - typeId: 0
  if (!Hive.isAdapterRegistered(0)) {
    Hive.registerAdapter(InventionAdapter());
  }

  // Favorite - typeId: 2
  if (!Hive.isAdapterRegistered(2)) {
    Hive.registerAdapter(FavoriteModelAdapter());
  }

  // User - typeId: 3
  if (!Hive.isAdapterRegistered(3)) {
    Hive.registerAdapter(UserModelAdapter());
  }

  // Idea - typeId: 4
  if (!Hive.isAdapterRegistered(4)) {
    Hive.registerAdapter(IdeaModelAdapter());
  }

  // =========================
  // Open Hive Boxes
  // =========================

  await Hive.openBox<Invention>(
    'inventions',
  );

  await Hive.openBox<FavoriteModel>(
    'favorites',
  );

  await Hive.openBox<UserModel>(
    'users',
  );

  await Hive.openBox<IdeaModel>(
    'ideas',
  );

  await Hive.openBox(
    'settings',
  );

  // =========================
  // Start Application
  // =========================

  runApp(
    const ProviderScope(
      child: InvenShareApp(),
    ),
  );
}

class InvenShareApp extends ConsumerWidget {
  const InvenShareApp({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final locale = ref.watch(
      localeProvider,
    );

    final themeMode = ref.watch(
      themeProvider,
    );

    final font = ref.watch(
      fontProvider,
    );

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

      supportedLocales:
          AppLocalizations.supportedLocales,

      theme: AppTheme.light(
        font,
      ),

      darkTheme: AppTheme.dark(
        font,
      ),

      themeMode: themeMode,

      home: const SplashPage(),
    );
  }
}