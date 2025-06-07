import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/providers/viewmodel/post_viewmodel_providers.dart';
import '../../../shared/state/base_con_state.dart';

class PostWriteScreen extends ConsumerStatefulWidget {
  const PostWriteScreen({super.key});

  @override
  ConsumerState<PostWriteScreen> createState() => _PostWriteScreenState();
}

class _PostWriteScreenState extends BaseConState<PostWriteScreen> {
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final title = _titleController.text.trim();
    final body = _bodyController.text.trim();

    if (title.isEmpty || body.isEmpty) {
      _showError('제목과 내용을 모두 입력하세요.');
      return;
    }

    final success = await ref
        .read(postWriteViewModelProvider.notifier)
        .submit(title, body);

    if (!mounted) return;

    if (success) {
      // context.go('/posts');
      context.pop();
    } else {
      final error = ref.read(postWriteViewModelProvider).error?.message;
      _showError(error ?? '작성 실패');
    }
  }

  void _showError(String msg) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(msg), backgroundColor: Colors.red));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postWriteViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('글 작성')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: '제목'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: '내용'),
              maxLines: 5,
            ),
            const SizedBox(height: 20),
            state.isLoading == true
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: _onSubmit,
                  child: const Text('작성 완료'),
                ),
          ],
        ),
      ),
    );
  }
}
