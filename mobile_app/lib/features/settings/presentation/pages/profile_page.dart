import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../l10n/app_localizations.dart';

import '../../../auth/presentation/providers/auth_provider.dart';

import 'edit_profile_page.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  ConsumerState<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  Future<void> pickProfileImage() async {
    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,

      imageQuality: 80,
    );

    if (image == null) {
      return;
    }

    final user = ref.read(currentUserProvider);

    if (user == null) {
      return;
    }

    final updatedUser = user.copyWith(profileImage: image.path);

    await ref.read(authProvider.notifier).updateProfile(updatedUser);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final user = ref.watch(currentUserProvider);

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.profileTitle)),

      body: user == null
          ? Center(child: Text(l10n.notLoggedIn))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),

              child: Column(
                children: [
                  Container(
                    width: double.infinity,

                    padding: const EdgeInsets.all(20),

                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer,

                      borderRadius: BorderRadius.circular(24),
                    ),

                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: pickProfileImage,

                          child: CircleAvatar(
                            radius: 45,

                            backgroundColor: theme.colorScheme.primary,

                            backgroundImage: user.profileImage.isNotEmpty
                                ? FileImage(File(user.profileImage))
                                : null,

                            child: user.profileImage.isEmpty
                                ? Icon(
                                    Icons.person,

                                    size: 50,

                                    color: theme.colorScheme.onPrimary,
                                  )
                                : null,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          user.name.isEmpty ? user.username : user.name,

                          style: theme.textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),

                        Text(l10n.inventor, style: theme.textTheme.bodyMedium),

                        const SizedBox(height: 10),

                        TextButton.icon(
                          onPressed: pickProfileImage,

                          icon: const Icon(Icons.photo),

                          label: Text(l10n.images),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  Row(
                    children: [
                      Expanded(
                        child: _statCard(
                          context,

                          "0",

                          l10n.inventions,

                          Icons.lightbulb_outline,
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: _statCard(
                          context,

                          "0",

                          l10n.ideas,

                          Icons.rocket_launch,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  _infoCard(
                    context,

                    Icons.person_outline,

                    l10n.username,

                    user.username,
                  ),

                  _infoCard(
                    context,

                    Icons.badge_outlined,

                    l10n.name,

                    user.name.isEmpty ? "-" : user.name,
                  ),

                  _infoCard(
                    context,

                    Icons.email_outlined,

                    l10n.email,

                    user.email.isEmpty ? "-" : user.email,
                  ),

                  _infoCard(
                    context,

                    Icons.engineering,

                    l10n.specialty,

                    user.specialty.isEmpty ? "-" : user.specialty,
                  ),

                  _infoCard(
                    context,

                    Icons.description_outlined,

                    l10n.bio,

                    user.bio.isEmpty ? "-" : user.bio,
                  ),

                  _infoCard(context, Icons.badge, l10n.role, user.role),

                  _infoCard(
                    context,

                    Icons.calendar_today,

                    l10n.membership,

                    "${user.createdAt.year}/"
                    "${user.createdAt.month}/"
                    "${user.createdAt.day}",
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,

                    child: FilledButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,

                          MaterialPageRoute(
                            builder: (_) => const EditProfilePage(),
                          ),
                        );
                      },

                      icon: const Icon(Icons.edit),

                      label: Text(l10n.editProfile),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _infoCard(
    BuildContext context,

    IconData icon,

    String title,

    String value,
  ) {
    return Card(
      child: ListTile(
        leading: Icon(icon),

        title: Text(title),

        subtitle: Text(value),
      ),
    );
  }

  Widget _statCard(
    BuildContext context,

    String number,

    String title,

    IconData icon,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [
            Icon(icon, size: 30, color: theme.colorScheme.primary),

            const SizedBox(height: 8),

            Text(number, style: theme.textTheme.headlineSmall),

            Text(title, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}
