import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../shared/state/base_con_state.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConState<LoginScreen> {
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

    final success = await ref
        .read(authViewModelProvider.notifier)
        .loginUser(userId);
    if (!mounted) return;

    if (success) {
      // context.goNamed(AppRoutesInfo.posts.name);
      context.pop();
    } else {
      final error = ref.read(authViewModelProvider).errorMessage;
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
    final state = ref.watch(authViewModelProvider);

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
