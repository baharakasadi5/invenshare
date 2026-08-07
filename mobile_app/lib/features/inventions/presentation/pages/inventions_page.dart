import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import 'add_invention_page.dart';
import 'invention_details_page.dart';

import '../providers/invention_provider.dart';
import '../providers/invention_filter_provider.dart';

class InventionsPage extends ConsumerWidget {
  const InventionsPage({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final l10n = AppLocalizations.of(context)!;

    // لیست اختراعات فیلترشده
    final inventions = ref.watch(
      filteredInventionsProvider,
    );

    // تمام اختراعات
    final allInventions = ref.watch(
      inventionStateProvider,
    );

    // --------------------------------------------------
    // ساخت لیست دسته‌بندی‌ها
    // --------------------------------------------------
    //
    // مشکل قبلی:
    // اگر یکی از اختراعات خودش category = "همه" داشته باشد،
    // مقدار l10n.all دوباره اضافه می‌شد و Dropdown
    // دو گزینه با value یکسان پیدا می‌کرد.
    //
    // بنابراین دسته‌بندی "همه" را از داده‌های ذخیره‌شده
    // حذف می‌کنیم و فقط یک بار خودمان اضافه می‌کنیم.
    // --------------------------------------------------

    final categorySet = <String>{};

    for (final invention in allInventions) {
      final category = invention.category.trim();

      if (category.isEmpty) {
        continue;
      }

      // جلوگیری از ایجاد گزینه تکراری "همه"
      if (category == l10n.all) {
        continue;
      }

      categorySet.add(category);
    }

    final categories = <String>[
      l10n.all,
      ...categorySet,
    ];

    // --------------------------------------------------
    // دسته‌بندی انتخاب‌شده
    // --------------------------------------------------

    final selectedCategory = ref.watch(
      inventionCategoryProvider,
    );

    // اگر مقدار ذخیره‌شده دیگر در لیست دسته‌بندی‌ها وجود
    // نداشته باشد، به صورت خودکار روی "همه" قرار می‌گیرد.
    final safeSelectedCategory =
        categories.contains(selectedCategory)
            ? selectedCategory
            : l10n.all;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.appTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // ==================================================
      // BODY
      // ==================================================

      body: Column(
        children: [
          // ==================================================
          // SEARCH + CATEGORY
          // ==================================================

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // --------------------------------------------------
                // SEARCH
                // --------------------------------------------------

                TextField(
                  decoration: InputDecoration(
                    hintText: l10n.searchInventions,
                    prefixIcon: const Icon(
                      Icons.search,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onChanged: (value) {
                    ref
                        .read(
                          inventionSearchProvider.notifier,
                        )
                        .state = value;
                  },
                ),

                const SizedBox(
                  height: 12,
                ),

                // --------------------------------------------------
                // CATEGORY DROPDOWN
                // --------------------------------------------------

                DropdownButtonFormField<String>(
                     initialValue: safeSelectedCategory,

                  decoration: InputDecoration(
                    labelText: l10n.category,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  // به علت استفاده از Set در بالا،
                  // دیگر مقدار تکراری وجود نخواهد داشت.
                  items: categories
                      .map(
                        (category) => DropdownMenuItem<String>(
                          value: category,
                          child: Text(
                            category,
                          ),
                        ),
                      )
                      .toList(),

                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }

                    ref
                        .read(
                          inventionCategoryProvider.notifier,
                        )
                        .state = value;
                  },
                ),
              ],
            ),
          ),

          // ==================================================
          // INVENTIONS LIST
          // ==================================================

          Expanded(
            child: inventions.isEmpty
                ? _EmptyInventionsView(
                    text: l10n.noInventionFound,
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),

                    itemCount: inventions.length,

                    separatorBuilder: (
                      context,
                      index,
                    ) {
                      return const SizedBox(
                        height: 12,
                      );
                    },

                    itemBuilder: (
                      context,
                      index,
                    ) {
                      final invention = inventions[index];

                      return Card(
                        elevation: 1,
                        clipBehavior: Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    InventionDetailsPage(
                                  invention: invention,
                                ),
                              ),
                            );
                          },

                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.all(16),

                            // --------------------------------------------------
                            // ICON
                            // --------------------------------------------------

                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.lightbulb_outline,
                              ),
                            ),

                            // --------------------------------------------------
                            // TITLE
                            // --------------------------------------------------

                            title: Text(
                              invention.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            // --------------------------------------------------
                            // DESCRIPTION
                            // --------------------------------------------------

                            subtitle: Text(
                              invention.description,
                              maxLines: 2,
                              overflow:
                              TextOverflow.ellipsis,
                            ),

                            // --------------------------------------------------
                            // DELETE
                            // --------------------------------------------------

                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_outline,
                              ),

                              onPressed: () {
                                _showDeleteDialog(
                                  context,
                                  ref,
                                  invention.id,
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),

      // ==================================================
      // ADD INVENTION BUTTON
      // ==================================================

      floatingActionButton:
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) =>
                  const AddInventionPage(),
            ),
          );
        },

        icon: const Icon(
          Icons.add,
        ),

        label: Text(
          l10n.addInvention,
        ),
      ),
    );
  }

  // ==================================================
  // DELETE CONFIRMATION
  // ==================================================

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(
            l10n.deleteInvention,
          ),

          content: Text(
            l10n.deleteConfirm,
          ),

          actions: [
            // --------------------------------------------------
            // CANCEL
            // --------------------------------------------------

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },

              child: Text(
                l10n.cancel,
              ),
            ),

            // --------------------------------------------------
            // DELETE
            // --------------------------------------------------

            FilledButton(
              onPressed: () async {
                await ref
                    .read(
                      inventionStateProvider.notifier,
                    )
                    .deleteInvention(id);

                if (context.mounted) {
                  Navigator.pop(context);
                }
              },

              child: Text(
                l10n.delete,
              ),
            ),
          ],
        );
      },
    );
  }
}

// ======================================================
// EMPTY INVENTIONS VIEW
// ======================================================

class _EmptyInventionsView extends StatelessWidget {
  final String text;

  const _EmptyInventionsView({
    required this.text,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Center(
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge,
      ),
    );
  }
}