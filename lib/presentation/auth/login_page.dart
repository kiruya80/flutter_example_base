import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../app/providers/viewmodel/auth_viewmodel_providers.dart';
import '../../shared/mixin/error_listener_mixin.dart';
import '../../shared/mixin/loading_listener_mixin.dart';
import '../../shared/mixin/navigation_listener_mixin.dart';
import '../../shared/state/base_con_state.dart';
import 'auth_state.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseConState<LoginPage>
    with
        ErrorListenerMixin<AuthState, LoginPage>,
        NavigationListenerMixin<AuthState, LoginPage>,
        LoadingListenerMixin<AuthState, LoginPage> {
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();

    // ✅ 로딩 리스너 등록
    setupErrorListener(ref, authViewModelProvider);
    setupLoadingListener(ref, authViewModelProvider);
    setupNavigationListener(ref, authViewModelProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      // ref.read(postListViewModelProvider.notifier).loadPosts();
    });
  }

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

    final success = await ref.read(authViewModelProvider.notifier).loginUser(userId);
    if (!mounted) return;

    if (success) {
      // context.goNamed(AppRoutesInfo.posts.name);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('로그인 성공.'), backgroundColor: Colors.blue));
      context.pop();
    } else {
      // final error = ref.read(authViewModelProvider).errorMessage;
      // _showError(error ?? '로그인 실패');
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), backgroundColor: Colors.red));
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
                ? Container()
                : ElevatedButton(onPressed: _onLoginPressed, child: const Text('로그인')),
          ],
        ),
      ),
    );
  }
}
