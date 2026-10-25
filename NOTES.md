# Lab 6 Notes

## Part 2
1. Why is the feed behind its own Provider?
   So it can be swapped out for tests and demos without changing tickerProvider. It also separates which feed to use from how its data is exposed.
2. What does autoDispose do when the user navigates away mid-stream?
   Riverpod disposes the provider, cancelling the stream and clearing state. Nothing keeps running. Coming back starts a fresh stream.
3. What AsyncValue does tickerProvider hold during the 800 ms delay, and what is hasValue at that moment?
   AsyncLoading, and hasValue is false because no data has arrived yet.

## Part 3
- 3.3 analyzer diagnostic (AsyncLoading arm commented out):
  error • The type 'AsyncValue<List<Tick>>' isn't exhaustively matched by the switch cases since it doesn't match the pattern 'AsyncLoading<List<Tick>>()' • lib/ticker_page.dart:12:7 • non_exhaustive_switch_expression
- 3.4 why specific arms go first: a switch runs the first arm that matches. AsyncData(:final value) matches every list, so if it came first, the empty and single-item arms would never run. Specific cases go first, general ones after.

## Part 4
- 4.3 refresh vs invalidate: Both keep the previous rows visible during reload, because AsyncValue carries the old value through the loading state. ref.refresh(tickerProvider.future) returns a Future that completes when new data arrives, so the RefreshIndicator spinner stays until the reload finishes. ref.invalidate returns void, so the spinner closes immediately.
- 4.4 arm order: the AsyncValue(:final value?, isLoading: true) arm sits above AsyncLoading(), so after a retry the rows stay with a thin progress bar and the full-screen spinner only shows on cold start.
- 4.4 isRefreshing vs isReloading: isRefreshing is true when the reload is triggered manually (ref.refresh or ref.invalidate), whereas isReloading is true when the provider rebuilds because one of its dependencies changed.

## Checkpoint questions
1. AsyncValue is sealed with three subtypes: AsyncData, AsyncLoading and AsyncError. If a switch expression misses one, the analyzer reports a compile error: non_exhaustive_switch_expression.
2. AsyncError.value is non-null when the provider already emitted data before the error (error after data, or a failed refresh/reload). It is null when the provider fails before producing any value, e.g. the first load fails.
3. ref.invalidate(provider) marks the provider stale so it rebuilds; it returns void. ref.refresh(provider) invalidates and immediately reads it again, returning the new AsyncValue. ref.refresh(provider.future) does the same but returns a Future of the next value, so it can be awaited (e.g. by RefreshIndicator).
4. During a refresh Riverpod keeps the previous data, so the state can be an AsyncData with isLoading = true. The general AsyncData(:final value) arm would match it first and the progress bar would never show, so the loading-with-value arm must come before it.
5. Switch expressions are checked for exhaustiveness by the compiler and can match on content and flags (value?, isLoading, empty lists), which .when cannot do. .when is still convenient for a quick one-liner in a widget, and its skipLoadingOnRefresh / skipError options handle refresh and error-with-data cases without extra arms.x