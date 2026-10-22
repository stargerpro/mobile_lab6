import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/tick.dart';
import '../services/tick_feed.dart';

final tickFeedProvider = Provider<TickFeed>((ref) {
  return TickFeed();
});

final tickerProvider = StreamProvider.autoDispose<List<Tick>>(
  (ref) => ref.watch(tickFeedProvider).watch(),
  retry: (_, _) => null,
  );