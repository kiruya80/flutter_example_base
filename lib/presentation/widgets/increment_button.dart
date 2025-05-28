import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../other/providers/count/counter_provider.dart';

class IncrementButton extends ConsumerWidget {
  const IncrementButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingActionButton(
      onPressed: () => ref.read(counterNotifierProvider.notifier).increment(),
      tooltip: 'Increment',
      child: const Icon(Icons.add),
    );
  }
}
