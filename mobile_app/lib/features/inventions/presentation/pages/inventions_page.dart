// lib/features/inventions/presentation/pages/inventions_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/invention.dart';
import '../providers/invention_provider.dart';

class InventionsPage extends ConsumerWidget {
  const InventionsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final inventions = ref.watch(inventionStateProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'InvenShare',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: inventions.isEmpty
          ? const _EmptyInventionsView()
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: inventions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final invention = inventions[index];

                return Card(
                  elevation: 1,
                  clipBehavior: Clip.antiAlias,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                      child: Icon(
                        Icons.lightbulb_outline_rounded,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    title: Text(
                      invention.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 6),
                      child: Text(
                        invention.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: IconButton(
                      tooltip: 'حذف اختراع',
                      icon: const Icon(Icons.delete_outline_rounded),
                      color: Colors.red,
                      onPressed: () {
                        _showDeleteDialog(
                          context: context,
                          ref: ref,
                          invention: invention,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showAddInventionDialog(context, ref);
        },
        icon: const Icon(Icons.add),
        label: const Text('ثبت اختراع'),
      ),
    );
  }

  void _showAddInventionDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('ثبت اختراع جدید'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  autofocus: true,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'عنوان اختراع',
                    hintText: 'مثلاً دستگاه هوشمند آبیاری',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: descriptionController,
                  minLines: 3,
                  maxLines: 5,
                decoration: const InputDecoration(
                    labelText: 'توضیحات',
                    hintText: 'ایده یا توضیح کوتاه اختراع را بنویسید...',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('انصراف'),
            ),
            FilledButton(
              onPressed: () {
                final title = titleController.text.trim();
                final description = descriptionController.text.trim();

                if (title.isEmpty || description.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('لطفاً عنوان و توضیحات را وارد کنید.'),
                    ),
                  );
                  return;
                }

                final invention = Invention(
                  id: DateTime.now().microsecondsSinceEpoch.toString(),
                  title: title,
                  description: description,
                  createdAt: DateTime.now(),
                );

                ref
                    .read(inventionStateProvider.notifier)
                    .addInvention(invention);

                Navigator.pop(dialogContext);
              },
              child: const Text('ذخیره'),
            ),
          ],
        );
      },
    );
  }

  void _showDeleteDialog({
    required BuildContext context,
    required WidgetRef ref,
    required Invention invention,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('حذف اختراع'),
          content: Text(
            'آیا از حذف «${invention.title}» مطمئن هستید؟',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('انصراف'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                ref
                    .read(inventionStateProvider.notifier)
                    .deleteInvention(invention.id);

                Navigator.pop(dialogContext);
              },
              child: const Text('حذف'),
            ),
          ],
        );
      },
    );
  }
}

class _EmptyInventionsView extends StatelessWidget {
  const _EmptyInventionsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.lightbulb_outline_rounded,
              size: 88,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 20),
            const Text(
              'هنوز اختراعی ثبت نشده است',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'با انتخاب «ثبت اختراع»، اولین ایده یا اختراع خود را به InvenShare اضافه کنید.',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}