import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/invention.dart';
import 'invention_provider.dart';

final inventionSearchProvider = StateProvider<String>((ref) {
  return '';
});

final inventionCategoryProvider = StateProvider<String>((ref) {
  return 'همه';
});

final filteredInventionsProvider = Provider<List<Invention>>((ref) {
  final inventions = ref.watch(inventionStateProvider);
  final search = ref.watch(inventionSearchProvider);
  final category = ref.watch(inventionCategoryProvider);

  final result = inventions.where((item) {
    bool searchOk = true;

    if (search.isNotEmpty) {
      searchOk =
          item.title.contains(search) ||
          item.description.contains(search) ||
          item.inventorName.contains(search);
    }

    bool categoryOk = true;

    if (category != 'همه') {
      categoryOk = item.category == category;
    }

    return searchOk && categoryOk;
  }).toList();

  return result;
});