part of 'movies_cubit.dart';

enum MoviesStatus { initial, loading, loaded, failure }

class MoviesState extends Equatable {
  final List<Movie> topMovies;
  final bool hasReachedMax;
  final MoviesStatus status;
  final Failure failure;

  const MoviesState({
    this.topMovies = const [],
    this.hasReachedMax = false,
    this.status = MoviesStatus.initial,
    this.failure = const Failure(),
  });

  @override
  List<Object> get props => [topMovies, hasReachedMax, status, failure];

  MoviesState copyWith({
    List<Movie>? topMovies,
    bool? hasReachedMax,
    MoviesStatus? status,
    Failure? failure,
  }) {
    return MoviesState(
      topMovies: topMovies ?? this.topMovies,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
