# Infinit Frontend Assessment

This flutter app presents a view with two tabs:

- Tab A: shows a paginated list with elements which redirect to their corresponding detailed view
- Tab B: it displays a dashboard with summary information regarding the loaded elements

The technical approach to use the API is via [Dio](https://pub.dev/packages/dio) plugin, a powerful HTTP networking package for Dart/Flutter.

As listing the API calls is a recurrent routine, it is a good practice to cache the results to improve responsiveness and reduce network usage. In order to accomplish this, [dio_cache_interceptor](https://pub.dev/packages/dio_cache_interceptor) plugin is implemented by using _HiveCacheStore_ as storing strategy, as it is widely cross-platform compatible.

The models are implemented by using [equatable](https://pub.dev/packages/equatable) to simplify objects comparison and [json_serializable](https://pub.dev/packages/json_serializable) to automate JSON serializing and deserializing.

The state management is implemented by using [bloc](flutter_bloc), that is Business Logic of Component, a way to architect the app so the UI is separated from the logic and repositories.

The app fetches the top most rated movies coming from The Movie Data Base (TMDB) API.
