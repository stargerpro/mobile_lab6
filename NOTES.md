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
