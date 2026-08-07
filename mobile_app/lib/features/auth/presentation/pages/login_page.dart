import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';

import '../providers/auth_provider.dart';

import 'register_page.dart';

import '../../../home/presentation/pages/inventor_dashboard_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final TextEditingController usernameController =
      TextEditingController();

  final TextEditingController passwordController =
      TextEditingController();

  bool loading = false;

  // ============================================================
  // Login
  // ============================================================

  Future<void> login() async {
    final l10n = AppLocalizations.of(context)!;

    final username = usernameController.text.trim();
    final password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      showMessage(l10n.loginRequired);
      return;
    }

    if (loading) {
      return;
    }

    setState(() {
      loading = true;
    });

    try {
      final success = await ref
          .read(authProvider.notifier)
          .login(
            username,
            password,
          );

      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
      });

      if (success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const InventorDashboardPage(),
          ),
        );
      } else {
        showMessage(l10n.invalidLogin);
      }
    } catch (_) {
      if (!mounted) {
        return;
      }

      setState(() {
        loading = false;
      });

      showMessage(l10n.invalidLogin);
    }
  }

  // ============================================================
  // Show Message
  // ============================================================

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

  // ============================================================
  // Build
  // ============================================================

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.loginToApp,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),

          child: Card(
            elevation: 8,

            child: Padding(
              padding: const EdgeInsets.all(25),

              child: Column(
                mainAxisSize: MainAxisSize.min,

                children: [
                  // ==================================================
                  // LOGIN IMAGE
                  // ==================================================

                  Container(
                    width: 120,
                    height: 120,

                    decoration: BoxDecoration(
                      shape: BoxShape.circle,

                      color:
                          theme.colorScheme.primaryContainer,
                    ),

                    clipBehavior: Clip.antiAlias,

                    child: Image.asset(
                      'assets/images/inventor.png',

                      fit: BoxFit.cover,

                      errorBuilder:
                          (context, error, stackTrace) {
                        return Icon(
                          Icons.lightbulb,
                          size: 65,
                          color:
                              theme.colorScheme.primary,
                              );
                      },
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ==================================================
                  // TITLE
                  // ==================================================

                  Text(
                    l10n.loginToApp,

                    style:
                        theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),

                    textAlign: TextAlign.center,
                  ),

                  const SizedBox(height: 25),

                  // ==================================================
                  // USERNAME
                  // ==================================================

                  TextField(
                    controller: usernameController,

                    enabled: !loading,

                    textInputAction:
                        TextInputAction.next,

                    decoration: InputDecoration(
                      labelText: l10n.username,

                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // ==================================================
                  // PASSWORD
                  // ==================================================

                  TextField(
                    controller: passwordController,

                    enabled: !loading,

                    obscureText: true,

                    textInputAction:
                        TextInputAction.done,

                    onSubmitted: (_) {
                      if (!loading) {
                        login();
                      }
                    },

                    decoration: InputDecoration(
                      labelText: l10n.password,

                      prefixIcon: const Icon(
                        Icons.lock_outline,
                      ),

                      border: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(16),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),

                  // ==================================================
                  // LOGIN BUTTON
                  // ==================================================

                  SizedBox(
                    width: double.infinity,

                    height: 52,

                    child: FilledButton.icon(
                      onPressed:
                          loading ? null : login,

                      icon: loading
                          ? const SizedBox(
                              width: 20,
                              height: 20,

                              child:
                                  CircularProgressIndicator(
                                strokeWidth: 2,
                              ),
                            )
                          : const Icon(
                              Icons.login,
                            ),

                      label: Text(
                        loading
                            ? l10n.loading
                            : l10n.login,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),
                  // ==================================================
                  // REGISTER
                  // ==================================================

                  TextButton(
                    onPressed: loading
                        ? null
                        : () {
                            Navigator.push(
                              context,

                              MaterialPageRoute(
                                builder: (_) =>
                                    const RegisterPage(),
                              ),
                            );
                          },

                    child: Text(
                      l10n.noAccountRegister,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // Dispose
  // ============================================================

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();

    super.dispose();
  }
}