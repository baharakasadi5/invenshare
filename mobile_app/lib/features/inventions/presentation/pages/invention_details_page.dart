// lib/features/inventions/presentation/pages/invention_details_page.dart

import '../providers/invention_provider.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/invention.dart';

import '../../../favorites/presentation/providers/favorite_provider.dart';

import 'edit_invention_page.dart';

// AI Service
import '../../../../services/local_ai_service.dart';

class InventionDetailsPage extends ConsumerStatefulWidget {
  final Invention invention;

  const InventionDetailsPage({
    super.key,
    required this.invention,
  });

  @override
  ConsumerState<InventionDetailsPage> createState() =>
      _InventionDetailsPageState();
}

class _InventionDetailsPageState
    extends ConsumerState<InventionDetailsPage> {
  String aiResult = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    // اگر قبلاً AI Analysis ذخیره شده باشد
    aiResult = widget.invention.aiAnalysis;
  }

  // ============================================================
  // IMAGE WIDGET
  // ============================================================

  Widget _buildInventionImages(
    BuildContext context,
    AppLocalizations l10n,
  ) {
    final images = widget.invention.images;

    // هیچ تصویری وجود ندارد
    if (images.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Icon(
              Icons.image_not_supported_outlined,
              size: 55,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant,
            ),
            const SizedBox(height: 10),
            Text(
              l10n.noImages,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        final String imagePath = images[index];

        final File imageFile =
            File(imagePath);

        return GestureDetector(
          onTap: () {
            _openFullScreenImage(
              context,
              imagePath,
            );
          },
          child: ClipRRect(
            borderRadius:
                BorderRadius.circular(16),
            child: imageFile.existsSync()
                ? Image.file(
                    imageFile,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (
                      context,
                      error,
                      stackTrace,
                    ) {
                      return _brokenImage();
                    },
                  )
                : _brokenImage(),
          ),
        );
      },
    );
  }

  // ============================================================
  // BROKEN IMAGE
  // ============================================================

  Widget _brokenImage() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius:
            BorderRadius.circular(16),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.broken_image_outlined,
            size: 45,
          ),
          SizedBox(height: 8),
          Text(
            'تصویر پیدا نشد',

textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  // ============================================================
  // FULL SCREEN IMAGE
  // ============================================================

  void _openFullScreenImage(
    BuildContext context,
    String imagePath,
  ) {
    final File imageFile =
        File(imagePath);

    if (!imageFile.existsSync()) {
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor:
                  Colors.black,
              foregroundColor:
                  Colors.white,
            ),
            body: Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4,
                child: Image.file(
                  imageFile,
                  fit: BoxFit.contain,
                  errorBuilder:
                      (
                    context,
                    error,
                    stackTrace,
                  ) {
                    return const Icon(
                      Icons
                          .broken_image_outlined,
                      color: Colors.white,
                      size: 80,
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final invention =
        widget.invention;

    final l10n =
        AppLocalizations.of(context)!;

    final isFavorite =
        ref.watch(favoriteProvider)
            .contains(invention.id);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.details),

        actions: [
          // FAVORITE
          IconButton(
            icon: Icon(
              isFavorite
                  ? Icons.favorite
                  : Icons.favorite_border,
              color:
                  isFavorite
                      ? Colors.red
                      : null,
            ),
            tooltip: l10n.favorite,
            onPressed: () async {
              await ref
                  .read(
                    favoriteProvider
                        .notifier,
                  )
                  .toggleFavorite(
                    invention.id,
                  );
            },
          ),

          // EDIT
          IconButton(
            icon: const Icon(
              Icons.edit_outlined,
            ),
            tooltip:
                l10n.editInvention,
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      EditInventionPage(
                    invention:
                        invention,
                  ),
                ),
              );

              // بعد از برگشت از صفحه ویرایش
              // صفحه جزئیات دوباره از Hive
              // اطلاعات جدید را دریافت می‌کند.
              if (mounted) {
                final updatedList =
                    ref.read(
                  inventionStateProvider,
                );

                final updated =
                    updatedList.firstWhere(
                  (item) =>
                      item.id ==
                      invention.id,
                  orElse: () =>
                      invention,
                );

                setState(() {
                  aiResult =
                      updated.aiAnalysis;
                });
              }
            },
          ),
        ],
      ),

      // ========================================================
      // BODY
      // ========================================================

      body: SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),
            child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start,

          children: [
            // ====================================================
            // TITLE
            // ====================================================

            Text(
              invention.title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // INFORMATION
            // ====================================================

            _buildCard(
              icon:
                  Icons.description_outlined,
              title:
                  l10n.description,
              value:
                  invention.description,
            ),

            _buildCard(
              icon:
                  Icons.category_outlined,
              title:
                  l10n.category,
              value:
                  invention.category,
            ),

            _buildCard(
              icon:
                  Icons.person_outline,
              title:
                  l10n.inventorName,
              value:
                  invention.inventorName,
            ),

            _buildCard(
              icon:
                  Icons.calendar_today_outlined,
              title:
                  l10n.date,
              value:
                  '${invention.createdAt.year}/${invention.createdAt.month}/${invention.createdAt.day}',
            ),

            _buildCard(
              icon:
                  Icons.info_outline,
              title:
                  l10n.status,
              value:
                  invention.status,
            ),

            const SizedBox(height: 20),

            // ====================================================
            // IMAGES
            // ====================================================

            Text(
              l10n.images,
              style: const TextStyle(
                fontSize: 18,
                fontWeight:
                    FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            _buildInventionImages(
              context,
              l10n,
            ),

            const SizedBox(height: 25),

            // ====================================================
            // AI BUTTON
            // ====================================================

            AnimatedContainer(
              duration:
                  const Duration(
                milliseconds: 300,
              ),
              decoration:
                  BoxDecoration(
                gradient:
                    const LinearGradient(
                  colors: [
                    Color(0xFF6A11CB),
                    Color(0xFF2575FC),
                  ],
                  begin:
                      Alignment.topLeft,
                  end:
                      Alignment.bottomRight,
                ),
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black
                        .withValues(
                      alpha: 0.15,
                    ),
                    blurRadius: 12,
                    offset:
                        const Offset(
                      0,
                      6,
                    ),
                  ),
                ],
              ),

              child: ElevatedButton(
                style:
                    ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent,
                  shadowColor:
                      Colors.transparent,
                  padding:
                  const EdgeInsets
                          .symmetric(
                    vertical: 16,
                    horizontal: 20,
                  ),
                  shape:
                      RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius
                            .circular(
                      14,
                    ),
                  ),
                ),

                onPressed:
                    isLoading
                        ? null
                        : () async {
                            setState(() {
                              isLoading =
                                  true;
                            });

                            try {
                              final ai =
                                  LocalAIService();

                              await ai
                                  .initModel();

                              final result =
                                  await ai
                                      .analyzeInvention(
                                title:
                                    invention
                                        .title,
                                description:
                                    invention
                                        .description,
                                category:
                                    invention
                                        .category,
                                inventor:
                                    invention
                                        .inventorName,
                              );

                              if (!mounted) {
                                return;
                              }

                              setState(() {
                                aiResult =
                                    result;
                                isLoading =
                                    false;
                              });
                            } catch (e) {
                              if (!mounted) {
                                return;
                              }

                              setState(() {
                                aiResult =
                                    'AI Error: $e';
                                isLoading =
                                    false;
                              });
                            }
                          },

                child: Row(
                  mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                  children: [
                    const Icon(
                      Icons.auto_awesome,
                      color:
                          Colors.white,
                    ),

                    const SizedBox(
                      width: 10,
                    ),

                    Text(
                      l10n.aiAnalysis,
                      style:
                          const TextStyle(
                        color:
                            Colors.white,
                        fontSize: 17,
                        fontWeight:
                            FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // ====================================================
            // AI RESULT
            // ====================================================

            Container(
              width:
                  double.infinity,
              padding:
                  const EdgeInsets.all(
                16,
              ),
              decoration:
                  BoxDecoration(
                color: Colors
                    .grey
                    .shade100,
                borderRadius:
                    BorderRadius.circular(
                  12,
                ),
              ),
              child: isLoading
                  ? const Center(
                      child:
                          CircularProgressIndicator(),
                    )
                  : Text(
                      aiResult.isEmpty
                          ? 'No AI analysis yet.'
                          : aiResult,
                      style:
                          const TextStyle(
                        fontSize: 15,
                      ),
                    ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // INFORMATION CARD
  // ============================================================

  Widget _buildCard({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Card(
      margin:
          const EdgeInsets.only(
        bottom: 12,
      ),

      child: ListTile(
        leading:
            Icon(icon),

        title: Text(
          title,
          style:
              const TextStyle(
            fontWeight:
                FontWeight.bold,
          ),
        ),

        subtitle: Padding(
          padding:
              const EdgeInsets.only(
            top: 6,
          ),
          child: Text(value),
        ),
      ),
    );
  }
}