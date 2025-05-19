import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widgets/counter_display.dart';
import '../widgets/counter_ge_display.dart';
import '../widgets/increment_button.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return Scaffold(
      appBar: AppBar(title: const Text('Counter App')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('riverpod 샘플', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: 30),

            Text('StateNotifierProvider 사용', style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 10),
            const CounterDisplay(),

            const SizedBox(height: 30),
            Text(
              'AutoDisposeAsyncNotifierProvider 사용(riverpod_generator)',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 10),
            const CounterGeDisplay(),
            const SizedBox(height: 30),

            // ref.watch(counterNotifierProvider).when(
            //   data: (counter) => Text('Data: ${counter.value}'),
            //   loading: () => const Text('Loading...'),
            //   error: (error, stackTrace) => Text('Error: $error'),
            // ),
          ],
        ),
      ),
      floatingActionButton: const IncrementButton(),
    );
  }
}
