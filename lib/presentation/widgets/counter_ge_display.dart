import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/utils/print_log.dart';
import '../other/providers/count/counter_ge_notifier.dart';

///
/// CounterGeNotifier 사용
///
class CounterGeDisplay extends ConsumerWidget {
  const CounterGeDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterGeState = ref.watch(counterGeNotifierProvider);

    return Container(
      child: counterGeState.when(
        data: (counter) {
          QcLog.d('counterGeNotifierProvider ===== ${counter.toString()}');
          return Column(
            children: [
              Text(
                'counterGeNotifierProvider : ${counter.value}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterGeNotifierProvider.notifier).resetCount();
                },
                child: Text('리셋'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterGeNotifierProvider.notifier).increment();
                },
                child: Text('증가'),
              ),
            ],
          );
        },
        loading: () => const CircularProgressIndicator(),
        error: (error, stackTrace) => Text('Error: $error'),
      ),
    );
  }
}
