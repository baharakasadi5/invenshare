// lib/features/inventions/presentation/pages/edit_invention_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/invention.dart';
import '../providers/invention_provider.dart';

class EditInventionPage extends ConsumerStatefulWidget {
  final Invention invention;

  const EditInventionPage({
    super.key,
    required this.invention,
  });

  @override
  ConsumerState<EditInventionPage> createState() =>
      _EditInventionPageState();
}

class _EditInventionPageState
    extends ConsumerState<EditInventionPage> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController categoryController;
  late TextEditingController inventorController;
  late TextEditingController statusController;
  late TextEditingController aiController;

  final ImagePicker _imagePicker = ImagePicker();

  late List<String> _imagePaths;

  bool _isPickingImage = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    final invention = widget.invention;

    titleController = TextEditingController(
      text: invention.title,
    );

    descriptionController = TextEditingController(
      text: invention.description,
    );

    categoryController = TextEditingController(
      text: invention.category,
    );

    inventorController = TextEditingController(
      text: invention.inventorName,
    );

    statusController = TextEditingController(
      text: invention.status,
    );

    aiController = TextEditingController(
      text: invention.aiAnalysis,
    );

    // تصاویر قبلی اختراع
    _imagePaths = List<String>.from(
      invention.images,
    );
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    inventorController.dispose();
    statusController.dispose();
    aiController.dispose();

    super.dispose();
  }

  // ============================================================
  // PICK MULTIPLE IMAGES
  // ============================================================

  Future<void> _pickImagesFromGallery() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
      final List<XFile> selectedImages =
          await _imagePicker.pickMultiImage(
        imageQuality: 90,
      );

      if (selectedImages.isEmpty) {
        return;
      }

      for (final XFile image in selectedImages) {
        final String savedPath =
            await _copyImageToAppStorage(image);

        if (!_imagePaths.contains(savedPath)) {
          _imagePaths.add(savedPath);
        }
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      _showMessage(
        'خطا در انتخاب تصاویر: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    }
  }

  // ============================================================
  // TAKE PHOTO
  // ============================================================

  Future<void> _takePhotoWithCamera() async {
    if (_isPickingImage) return;

    setState(() {
      _isPickingImage = true;
    });

    try {
      final XFile? image =
          await _imagePicker.pickImage(
        source: ImageSource.camera,
        imageQuality: 90,
      );

      if (image == null) {
        return;
      }

      final String savedPath =
          await _copyImageToAppStorage(image);

      if (!_imagePaths.contains(savedPath)) {
        _imagePaths.add(savedPath);
      }

      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      _showMessage(
        'خطا در گرفتن عکس: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
          });
      }
    }
  }

  // ============================================================
  // COPY IMAGE TO APP STORAGE
  // ============================================================

  Future<String> _copyImageToAppStorage(
    XFile image,
  ) async {
    final Directory appDirectory =
        await getApplicationSupportDirectory();

    final Directory imagesDirectory =
        Directory(
      '${appDirectory.path}/invention_images',
    );

    if (!await imagesDirectory.exists()) {
      await imagesDirectory.create(
        recursive: true,
      );
    }

    final String extension =
        _getFileExtension(image.path);

    final String fileName =
        '${const Uuid().v4()}$extension';

    final String destinationPath =
        '${imagesDirectory.path}/$fileName';

    final File sourceFile =
        File(image.path);

    final File destinationFile =
        await sourceFile.copy(
      destinationPath,
    );

    return destinationFile.path;
  }

  // ============================================================
  // FILE EXTENSION
  // ============================================================

  String _getFileExtension(String path) {
    final int dotIndex =
        path.lastIndexOf('.');

    if (dotIndex == -1) {
      return '.jpg';
    }

    return path.substring(dotIndex);
  }

  // ============================================================
  // IMAGE SOURCE MENU
  // ============================================================

  Future<void> _showImageSourceMenu() async {
    if (_isPickingImage) return;

    await showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext sheetContext) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                ),
                title: const Text(
                  'انتخاب از گالری',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImagesFromGallery();
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                ),
                title: const Text(
                  'گرفتن عکس با دوربین',
                ),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _takePhotoWithCamera();
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  // ============================================================
  // DELETE IMAGE
  // ============================================================

  Future<void> _removeImage(int index) async {
    if (index >= _imagePaths.length || _isPickingImage) {
  return;
}

    final String path =
        _imagePaths[index];

    final bool? confirmed =
        await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            'حذف تصویر',
          ),
          content: const Text(
            'آیا می‌خواهید این تصویر حذف شود؟',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  false,
                );
              },
              child: const Text(
                'لغو',
              ),
            ),
            FilledButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  true,
                );
              },
              child: const Text(
                'حذف',
              ),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    setState(() {
      _imagePaths.removeAt(index);
    });

    // حذف فایل فیزیکی
    try {
      final File file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // حذف نشدن فایل فیزیکی نباید باعث Crash شود.
    }
  }

  // ============================================================
  // REPLACE IMAGE
  // ============================================================

Future<void> _replaceImage(int index) async {
     
if (index >= _imagePaths.length || _isPickingImage) {
  return;
}


    final String? source =
        await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.photo_library_outlined,
                ),
                title: const Text(
                  'انتخاب تصویر جدید از گالری',
                ),
                onTap: () {
                  Navigator.pop(
                    context,
                    'gallery',
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.camera_alt_outlined,
                ),
                title: const Text(
                  'گرفتن تصویر جدید با دوربین',
                ),
                onTap: () {
                  Navigator.pop(
                    context,
                    'camera',
                  );
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );

    if (source == null) {
      return;
    }

    setState(() {
      _isPickingImage = true;
    });

    try {
      XFile? selectedImage;

      if (source == 'gallery') {
        selectedImage =
            await _imagePicker.pickImage(
          source: ImageSource.gallery,
          imageQuality: 90,
        );
      } else {
        selectedImage =
            await _imagePicker.pickImage(
          source: ImageSource.camera,
          imageQuality: 90,
        );
      }

      if (selectedImage == null) {
        return;
      }

      final String newPath =
          await _copyImageToAppStorage(
        selectedImage,
      );

      final String oldPath =
          _imagePaths[index];

      setState(() {
        _imagePaths[index] = newPath;
      });

      // حذف فایل قبلی
      try {
        final File oldFile =
            File(oldPath);

        if (await oldFile.exists()) {
          await oldFile.delete();
        }
      } catch (_) {}
    } catch (e) {
      _showMessage(
        'خطا در جایگزینی تصویر: $e',
      );
    } finally {
      if (mounted) {
        setState(() {
          _isPickingImage = false;
        });
      }
    }
  }

  // ============================================================
  // IMAGE PREVIEW
  // ============================================================

  Widget _buildImageSection() {
    return Column(
      crossAxisAlignment:
          CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.photo_library_outlined,
            ),
            const SizedBox(width: 8),
            Text(
              'تصاویر اختراع',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(
                    fontWeight:
                        FontWeight.bold,
                  ),
            ),
          ],
        ),

        const SizedBox(height: 12),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed:
                _isPickingImage
                    ? null
                    : _showImageSourceMenu,
            icon: _isPickingImage
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                        CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                    )
                : const Icon(
                    Icons.add_a_photo_outlined,
                  ),
            label: Text(
              _isPickingImage
                  ? 'در حال انتخاب تصویر...'
                  : 'افزودن تصویر',
            ),
            style:
                OutlinedButton.styleFrom(
              minimumSize:
                  const Size(
                double.infinity,
                50,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),
          ),
        ),

        if (_imagePaths.isEmpty)
          Padding(
            padding:
                const EdgeInsets.only(
              top: 16,
            ),
            child: Container(
              width: double.infinity,
              padding:
                  const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
              child: const Column(
                children: [
                  Icon(
                    Icons.image_not_supported_outlined,
                    size: 45,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'تصویری برای این اختراع وجود ندارد',
                  ),
                ],
              ),
            ),
          ),

        if (_imagePaths.isNotEmpty) ...[
          const SizedBox(height: 16),

          Text(
            '${_imagePaths.length} تصویر',
            style: Theme.of(context)
                .textTheme
                .bodyMedium,
          ),

          const SizedBox(height: 10),

          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(),
            itemCount:
                _imagePaths.length,
            gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder:
                (
              BuildContext context,
              int index,
            ) {
              final String imagePath =
                  _imagePaths[index];

              final File imageFile =
                  File(imagePath);

              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
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

                  // شماره تصویر
                  Positioned(
                    left: 5,
                    top: 5,
                    child: Container(
                      padding:
                          const EdgeInsets.symmetric(
                        horizontal: 7,
                        vertical: 4,
                      ),
                      decoration:
                          BoxDecoration(
                        color: Colors.black54,
                        borderRadius:
                            BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Text(
                        '${index + 1}',
                        style:
                            const TextStyle(
                          color: Colors.white,
                          fontWeight:
                              FontWeight.bold,
                        ),
                      ),
                    ),
                  ),

                  // منوی تصویر
                  Positioned(
                    right: 5,
                    top: 5,
                    child: PopupMenuButton<String>(
                      color: Theme.of(context)
                          .colorScheme
                          .surface,
                      icon: const Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      ),
                      onSelected:
                          (value) {
                        if (value ==
                            'replace') {
                          _replaceImage(
                            index,
                          );
                        }

                        if (value ==
                            'delete') {
                          _removeImage(
                            index,
                          );
                        }
                      },
                      itemBuilder:
                          (context) => [
                        const PopupMenuItem(
                          value: 'replace',
                          child: Row(
                            children: [
                              Icon(
                                Icons.swap_horiz,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'جایگزینی تصویر',
                              ),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete_outline,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                'حذف تصویر',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ],
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
            BorderRadius.circular(12),
      ),
      child: const Center(
        child: Icon(
          Icons.broken_image_outlined,
          size: 35,
        ),
      ),
    );
  }

  // ============================================================
  // SAVE CHANGES
  // ============================================================

  Future<void> saveChanges() async {
    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final Invention updatedInvention =
          widget.invention.copyWith(
        title:
            titleController.text.trim(),

        description:
            descriptionController.text.trim(),

        category:
            categoryController.text.trim(),

        inventorName:
            inventorController.text.trim(),

        status:
            statusController.text.trim(),

        aiAnalysis:
            aiController.text.trim(),

        images:
            List<String>.from(
          _imagePaths,
        ),
      );

      await ref
          .read(
            inventionStateProvider.notifier,
            )
          .updateInvention(
            updatedInvention,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'تغییرات با موفقیت ذخیره شد.',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _isSaving = false;
      });

      _showMessage(
        'خطا در ذخیره تغییرات: $e',
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ============================================================
  // FORM FIELD
  // ============================================================

  Widget _field({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding:
          const EdgeInsets.only(
        bottom: 15,
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration:
            InputDecoration(
          labelText: label,
          prefixIcon:
              Icon(icon),
          border:
              OutlineInputBorder(
            borderRadius:
                BorderRadius.circular(
              16,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(
    BuildContext context,
  ) {
    final l10n =
        AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.editInvention,
        ),
      ),

      body:
          SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [
            _field(
              controller:
                  titleController,
              label:
                  l10n.inventionTitle,
              icon:
                  Icons.lightbulb_outline,
            ),

            _field(
              controller:
                  descriptionController,
              label:
                  l10n.description,
              icon:
                  Icons.description_outlined,
              maxLines: 5,
            ),

            _field(
              controller:
                  categoryController,
              label:
                  l10n.category,
              icon:
                  Icons.category_outlined,
            ),

            _field(
              controller:
                  inventorController,
              label:
                  l10n.inventorName,
              icon:
                  Icons.person_outline,
            ),

            _field(
              controller:
                  statusController,
              label:
                  l10n.status,
              icon:
                  Icons.info_outline,
            ),

            _field(
              controller:
                  aiController,
              label:
                  l10n.aiAnalysis,
              icon:
                  Icons.auto_awesome,
              maxLines: 4,
            ),

            const SizedBox(height: 10),

            // ==================================================
            // IMAGES
            // ==================================================

            _buildImageSection(),

            const SizedBox(height: 30),

            // ==================================================
            // SAVE
            // ==================================================

            SizedBox(
              width:
                  double.infinity,
              height: 55,
              child:
              FilledButton.icon(
                icon: _isSaving
                    ? const SizedBox(
                        width: 22,
                        height: 22,
                        child:
                            CircularProgressIndicator(
                          strokeWidth: 2,
                          color:
                              Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.save,
                      ),
                label: Text(
                  _isSaving
                      ? 'در حال ذخیره...'
                      : l10n.saveChanges,
                ),
                onPressed:
                    _isSaving
                        ? null
                        : saveChanges,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
