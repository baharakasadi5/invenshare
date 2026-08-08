import 'dart:io';

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

    // ============================================================
    // FILTERED INVENTIONS
    // ============================================================

    final inventions = ref.watch(
      filteredInventionsProvider,
    );

    // ============================================================
    // ALL INVENTIONS
    // ============================================================

    final allInventions = ref.watch(
      inventionStateProvider,
    );

    // ============================================================
    // CATEGORIES
    // ============================================================

    final categorySet = <String>{};

    for (final invention in allInventions) {
      final category = invention.category.trim();

      if (category.isEmpty) {
        continue;
      }

      if (category == l10n.all) {
        continue;
      }

      categorySet.add(category);
    }

    final categories = <String>[
      l10n.all,
      ...categorySet,
    ];

    // ============================================================
    // SELECTED CATEGORY
    // ============================================================

    final selectedCategory = ref.watch(
      inventionCategoryProvider,
    );

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

      // ==========================================================
      // BODY
      // ==========================================================

      body: Column(
        children: [
          // ======================================================
          // SEARCH + CATEGORY
          // ======================================================

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // ==================================================
                // SEARCH
                // ==================================================

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

                // ==================================================
                // CATEGORY
                // ==================================================

                DropdownButtonFormField<String>(
                  initialValue: safeSelectedCategory,
                  decoration: InputDecoration(
                    labelText: l10n.category,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  items: categories
                      .map(
                        (category) =>
                            DropdownMenuItem<String>(
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

          // ======================================================
          // INVENTIONS
          // ======================================================

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
                      final invention =
                          inventions[index];

                      return Card(
                        elevation: 1,
                        clipBehavior:
                            Clip.antiAlias,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    InventionDetailsPage(
                                  invention:
                                      invention,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            contentPadding:
                                const EdgeInsets.all(
                              12,
                            ),

                            // ==================================================
                            // INVENTION IMAGE
                            // ==================================================

                            leading:
                                _buildInventionImage(
                              invention.images,
                            ),

                            // ==================================================
                            // TITLE
                            // ==================================================

                            title: Text(
                              invention.title,
                              style:
                                  const TextStyle(
                                fontWeight:
                                    FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow:
                                  TextOverflow.ellipsis,
                            ),

                            // ==================================================
                            // DESCRIPTION
                            // ==================================================

                            subtitle: Padding(
                              padding:
                              const EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text(
                                invention.description,
                                maxLines: 2,
                                overflow:
                                    TextOverflow.ellipsis,
                              ),
                            ),

                            // ==================================================
                            // DELETE
                            // ==================================================

                            trailing:
                                IconButton(
                              icon: const Icon(
                                Icons
                                    .delete_outline,
                              ),
                              tooltip:
                                  l10n.delete,
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

      // ==========================================================
      // ADD INVENTION
      // ==========================================================

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

  // ============================================================
  // INVENTION IMAGE
  // ============================================================

  Widget _buildInventionImage(
    List<String> imagePaths,
  ) {
    // ------------------------------------------------------------
    // No image
    // ------------------------------------------------------------

    if (imagePaths.isEmpty) {
      return const CircleAvatar(
        radius: 30,
        child: Icon(
          Icons.lightbulb_outline,
          size: 28,
        ),
      );
    }

    final String imagePath =
        imagePaths.first.trim();

    // ------------------------------------------------------------
    // Empty path
    // ------------------------------------------------------------

    if (imagePath.isEmpty) {
      return const CircleAvatar(
        radius: 30,
        child: Icon(
          Icons.lightbulb_outline,
          size: 28,
        ),
      );
    }

    // ------------------------------------------------------------
    // Local file image
    // ------------------------------------------------------------

    final File imageFile =
        File(imagePath);

    return ClipRRect(
      borderRadius:
          BorderRadius.circular(12),
      child: SizedBox(
        width: 60,
        height: 60,
        child: Image.file(
          imageFile,
          fit: BoxFit.cover,

          // ------------------------------------------------------
          // File does not exist / image is invalid
          // ------------------------------------------------------

          errorBuilder: (
            context,
            error,
            stackTrace,
          ) {
            return Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Theme.of(context)
                    .colorScheme
                    .surfaceContainerHighest,
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
                ),
              child: const Icon(
                Icons.broken_image_outlined,
                size: 28,
              ),
            );
          },
        ),
      ),
    );
  }

  // ============================================================
  // DELETE CONFIRMATION
  // ============================================================

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) {
    final l10n =
        AppLocalizations.of(context)!;

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
            // ----------------------------------------------------
            // CANCEL
            // ----------------------------------------------------

            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                l10n.cancel,
              ),
            ),

            // ----------------------------------------------------
            // DELETE
            // ----------------------------------------------------

            FilledButton(
              onPressed: () async {
                await ref
                    .read(
                      inventionStateProvider
                          .notifier,
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

// ================================================================
// EMPTY INVENTIONS VIEW
// ================================================================

class _EmptyInventionsView
    extends StatelessWidget {
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