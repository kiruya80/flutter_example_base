import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/count/counter_provider.dart';
import '../../utils/print_log.dart';


///
/// counterNotifierProvider 사용
///
class CounterDisplay extends ConsumerWidget {
  const CounterDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counterState = ref.watch(counterNotifierProvider);

    return Container(
      child: counterState.when(
        data: (counter) {
          /// counterNotifierProvider에 저장된 state 값을 가져온다
          /// 여기서는 Count 객체
          QcLog.d('counterNotifierProvider ===== $counter');
          return Column(
            children: [
              Text('count : ${counter.value}', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterNotifierProvider.notifier).resetCount();
                },
                child: Text('리셋'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(counterNotifierProvider.notifier).increment();
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
