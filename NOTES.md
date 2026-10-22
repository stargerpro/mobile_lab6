# Lab 6 Notes
## Part 2
1.Why is the feed behind its own Provider
It is because it can be swapped out for tests and demos  without changing the ticketProvider. It also separates which feed to use from how its data is exposed
2.What does autoDispose do when the user navigates away mid-stream
Riverpod disposes the provider, cancelling the stream and clearing state. Nothing keeps running. Coming back starts a fresh stream
3. What AsyncValue does tickerProvider hold dduring the  800 ms delay, and what is hasValue at that moment?
AsyncLoading, and hasValue is false because no data has arrived yet.
## Part 3
3.3
Analyzing riverpod_ticker...                                            

  error • The type 'AsyncValue<List<Tick>>' isn't exhaustively matched by the switch cases since it doesn't match the pattern 'AsyncLoading<List<Tick>>()'. Try adding a wildcard pattern or
         cases that match 'AsyncLoading<List<Tick>>()' • lib/ticker_page.dart:12:7 • non_exhaustive_switch_expression

1 issue found. (ran in 0.5s)
- 3.4 why specific arms go first: a switch runs the first arm that matches. AsyncData(:final value) matches every list, so if it came first, the empty and single-item arms would never run. So we must define the specific cases first and then the general ones.
## Part 4
- 4.3 refresh vs invalidate: Both keep the previous rows visible during reload, because AsyncValue carries the old value through the loading state. ref.refresh(tickerProvider.future) returns a Future that completes when new data arrives, so the RefreshIndicator spinner stays until the reload finishes. ref.invalidate returns void, so the spinner closes immediately.
- 4.4 arm order: the AsyncValue(:final value?, isLoading: true) arm sits above AsyncLoading(), so after a retry the rows stay with a thin progress bar and the full-screen spinner only shows on cold start.
Then explain in one sentence the difference between isRefreshing and isReloading on AsyncValue?
isRefreshing because of the manual triggers such as ref.refresh() or ref.invalidate() , whereas isReloading rebuilds because one of its dependancies changed
