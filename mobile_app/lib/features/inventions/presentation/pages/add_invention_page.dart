// lib/features/inventions/presentation/pages/add_invention_page.dart

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/invention.dart';
import '../providers/invention_provider.dart';

class AddInventionPage extends ConsumerStatefulWidget {
  const AddInventionPage({
    super.key,
  });

  @override
  ConsumerState<AddInventionPage> createState() =>
      _AddInventionPageState();
}

class _AddInventionPageState
    extends ConsumerState<AddInventionPage> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final categoryController = TextEditingController();
  final inventorController = TextEditingController();

  final ImagePicker _imagePicker = ImagePicker();

  final List<String> _imagePaths = [];

  bool _isSaving = false;
  bool _isPickingImage = false;

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    categoryController.dispose();
    inventorController.dispose();

    super.dispose();
  }

  // ============================================================
  // PICK IMAGE FROM GALLERY
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
  // TAKE PHOTO WITH CAMERA
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
        'خطا در گرفتن تصویر: $e',
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
  // COPY IMAGE TO PERMANENT APP STORAGE
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
  // GET FILE EXTENSION
  // ============================================================

  String _getFileExtension(
    String path,
  ) {
    final int dotIndex =
        path.lastIndexOf('.');

    if (dotIndex == -1) {
      return '.jpg';
    }

    return path.substring(dotIndex);
  }

  // ============================================================
  // REMOVE SELECTED IMAGE
  // ============================================================

  Future<void> _removeImage(
    int index,
  ) async {
    if (index < 0 ||
        index >= _imagePaths.length) {
      return;
    }

    final String path =
        _imagePaths[index];

    _imagePaths.removeAt(index);

    if (mounted) {
      setState(() {});
    }

    try {
      final File file = File(path);

      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {
      // Image is already removed from the list.
      // Failure to delete the physical file
      // should not stop the UI.
    }
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
  // SAVE INVENTION
  // ============================================================

  Future<void> saveInvention() async {
    final l10n =
        AppLocalizations.of(context)!;

    if (titleController.text.trim().isEmpty) {
      _showMessage(
        l10n.enterTitle,
      );
      return;
    }

    if (_isSaving) return;

    setState(() {
      _isSaving = true;
    });

    try {
      final Invention invention =
          Invention(
        id: const Uuid().v4(),

        title:
            titleController.text.trim(),

        description:
            descriptionController.text.trim(),

        category:
            categoryController.text.trim().isEmpty
                ? l10n.other
                : categoryController.text.trim(),

        inventorName:
            inventorController.text.trim().isEmpty
                ? l10n.unknown
                : inventorController.text.trim(),

        createdAt:
            DateTime.now(),

        aiAnalysis:
            '',

        status:
            l10n.initialRegistration,

        images:
            List<String>.from(_imagePaths),
      );

      await ref
          .read(
            inventionStateProvider.notifier,
          )
          .addInvention(
            invention,
          );

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(
        const SnackBar(
          content: Text(
            'اختراع با موفقیت ذخیره شد.',
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
        'خطا در ذخیره اختراع: $e',
      );
    }
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(
    String message,
  ) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
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

        if (_imagePaths.isNotEmpty) ...[
          const SizedBox(height: 16),

          Text(
            '${_imagePaths.length} تصویر انتخاب شده',
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
                (BuildContext context,
                    int index) {
              final String imagePath =
                  _imagePaths[index];

              return Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius:
                        BorderRadius.circular(
                      12,
                    ),
                    child: Image.file(
                      File(imagePath),
                      fit: BoxFit.cover,
                      errorBuilder:
                          (
                        context,
                        error,
                        stackTrace,
                      ) {
                        return Container(
                          decoration:
                          BoxDecoration(
                            color: Colors
                                .grey
                                .shade200,
                            borderRadius:
                                BorderRadius
                                    .circular(
                              12,
                            ),
                          ),
                          child:
                              const Icon(
                            Icons
                                .broken_image_outlined,
                          ),
                        );
                      },
                    ),
                  ),

                  Positioned(
                    top: 5,
                    right: 5,
                    child: Material(
                      color:
                          Colors.black54,
                      shape:
                          const CircleBorder(),
                      child: InkWell(
                        customBorder:
                            const CircleBorder(),
                        onTap: () =>
                            _removeImage(
                          index,
                        ),
                        child:
                            const Padding(
                          padding:
                              EdgeInsets.all(
                            5,
                          ),
                          child:
                              Icon(
                            Icons.close,
                            color:
                                Colors.white,
                            size: 18,
                          ),
                        ),
                      ),
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
  // FORM FIELD
  // ============================================================

  Widget buildField({
    required TextEditingController
        controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
  }) {
    return TextField(
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
          l10n.addNewInvention,
        ),
      ),

      body:
          SingleChildScrollView(
        padding:
            const EdgeInsets.all(20),

        child: Column(
          children: [
            buildField(
              controller:
                  titleController,
              label:
                  l10n.inventionTitle,
              icon:
                  Icons.lightbulb_outline,
            ),

            const SizedBox(
              height: 16,
            ),

            buildField(
              controller:
                  categoryController,
              label:
                  l10n.category,
              icon:
                  Icons.category_outlined,
            ),

            const SizedBox(
              height: 16,
            ),

            buildField(
              controller:
                  inventorController,
              label:
                  l10n.inventorName,
              icon:
                  Icons.person_outline,
            ),

            const SizedBox(
              height: 16,
            ),

            buildField(
              controller:
                  descriptionController,
              label:
              l10n.inventionDescription,
              icon:
                  Icons.description_outlined,
              maxLines: 5,
            ),

            const SizedBox(
              height: 25,
            ),

            // ==================================================
            // IMAGES
            // ==================================================

            _buildImageSection(),

            const SizedBox(
              height: 30,
            ),

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
                      : l10n.saveInvention,
                ),
                onPressed:
                    _isSaving
                        ? null
                        : saveInvention,
              ),
            ),
          ],
        ),
      ),
    );
  }
}