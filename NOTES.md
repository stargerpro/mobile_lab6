# Lab 6 Notes
## Part 2
1.Why is the feed behind its own Provider
It is because it can be swapped out for tests and demos  without changing the ticketProvider. It also separates which feed to use from how its data is exposed
2.What does autoDispose do when the user navigates away mid-stream
Riverpod disposes the provider, cancelling the stream and clearing state. Nothing keeps running. Coming back starts a fresh stream
3. What AsyncValue does tickerProvider hold dduring the  800 ms delay, and what is hasValue at that moment?
AsyncLoading, and hasValue is false because no data has arrived yet.