import 'dart:collection';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/loading/dialog_queue_manager.dart';

final dialogQueueProvider = StateNotifierProvider<DialogQueueManager, Queue<DialogRequest>>(
  (ref) => DialogQueueManager(),
);
