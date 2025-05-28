import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../application/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../core/base_con_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseConState<LoginPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _onLoginPressed() async {
    final userId = int.tryParse(_controller.text);
    if (userId == null) {
      _showError('숫자로 입력하세요');
      return;
    }

    final success = await ref.read(loginViewModelProvider.notifier).loginUser(userId);
    if (!mounted) return;

    if (success) {
      context.go('/posts');
    } else {
      final error = ref.read(loginViewModelProvider).errorMessage;
      _showError(error ?? '로그인 실패');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(loginViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('로그인')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('User ID를 입력하세요 (1~10)', style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'User ID'),
            ),
            const SizedBox(height: 16),
            state.isLoading == true
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _onLoginPressed,
                    child: const Text('로그인'),
                  ),
          ],
        ),
      ),
    );
  }
}
