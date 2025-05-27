import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/providers/auth_provider.dart';

class LoginScreen extends ConsumerWidget {
  final String? redirectPath;

  const LoginScreen({super.key, this.redirectPath});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                ref.read(authServiceProvider).login();
                if (redirectPath != null) {
                  context.go(redirectPath!);
                } else {
                  context.go('/posts');
                }
              },
              child: const Text('Login'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                ref.read(authServiceProvider).logout();
                if (redirectPath != null) {
                  context.go(redirectPath!);
                } else {
                  context.pop();
                }
              },
              child: const Text('logout'),
            ),
          ],
        ),
      ),
    );
  }
}
