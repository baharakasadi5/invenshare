import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../../domain/entities/user_model.dart';
import '../providers/auth_provider.dart';

import 'login_page.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() =>
      _RegisterPageState();
}

class _RegisterPageState
    extends ConsumerState<RegisterPage> {
  final TextEditingController nameController =
      TextEditingController();

  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  final TextEditingController specialtyController =
      TextEditingController();

  final TextEditingController bioController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool loading = false;

  Future<void> register() async {
    final l10n = AppLocalizations.of(context)!;

    final name = nameController.text.trim();
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final specialty = specialtyController.text.trim();
    final bio = bioController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword =
        confirmPasswordController.text.trim();

    if (username.isEmpty) {
      showMessage(l10n.usernameRequired);
      return;
    }

    if (password.isEmpty) {
      showMessage(l10n.passwordRequired);
      return;
    }

    if (password.length < 6) {
      showMessage(
        l10n.passwordTooShort,
      );
      return;
    }

    if (password != confirmPassword) {
      showMessage(
        l10n.passwordMismatch,
      );
      return;
    }

    if (loading) {
      return;
    }

    setState(() {
      loading = true;
    });

    final user = UserModel(
      username: username,
      password: password,
      name: name,
      email: email,
      specialty: specialty,
      bio: bio,
    );

    try {
      final error = await ref
          .read(authProvider.notifier)
          .register(user);

      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
      });

      if (error != null) {
        showMessage(error);
        return;
      }

      showMessage(
        l10n.registerSuccess,
      );

      await Future.delayed(
        const Duration(milliseconds: 500),
      );

      if (!mounted) {
        return;
      }

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const LoginPage(),
        ),
      );
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
      });

      showMessage(
        l10n.registerError,
      );
    }
  }

  void showMessage(String message) {
    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.createInventorAccount,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.fullName,
                prefixIcon: const Icon(
                  Icons.person,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: usernameController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.username,
                prefixIcon: const Icon(
                  Icons.account_circle,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: emailController,
              keyboardType:
                  TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.email,
                prefixIcon: const Icon(
                  Icons.email,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: specialtyController,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.specialty,
                prefixIcon: const Icon(
                  Icons.engineering,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: bioController,
              maxLines: 3,
              textInputAction: TextInputAction.newline,
              decoration: InputDecoration(
                labelText: l10n.bio,
                prefixIcon: const Icon(
                  Icons.description,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: passwordController,
              obscureText: true,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: l10n.password,
                prefixIcon: const Icon(
                  Icons.lock,
                ),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller:
                  confirmPasswordController,
              obscureText: true,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                if (!loading) {
                  register();
                }
              },
              decoration: InputDecoration(
                labelText: l10n.confirmPassword,
                prefixIcon: const Icon(
                  Icons.lock_outline,
                ),
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: loading ? null : register,
                child: loading
                    ? const SizedBox(
                        height: 22,
                        width: 22,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text(
                        l10n.register,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    specialtyController.dispose();
    bioController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
}