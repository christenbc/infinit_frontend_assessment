// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movies_cubit.dart';

enum MoviesStatus { initial, loading, loaded, complementaryDataLoaded, failure }

class MoviesState extends Equatable {
  final List<Movie> topMovies;
  final List<Language> languages;
  final bool hasReachedMax;
  final MoviesStatus status;
  final Failure failure;

  const MoviesState({
    this.topMovies = const [],
    this.languages = const [],
    this.hasReachedMax = false,
    this.status = MoviesStatus.initial,
    this.failure = const Failure(),
  });

  @override
  List<Object> get props => [topMovies, languages, hasReachedMax, status, failure];

  MoviesState copyWith({
    List<Movie>? topMovies,
    List<Language>? languages,
    bool? hasReachedMax,
    MoviesStatus? status,
    Failure? failure,
  }) {
    return MoviesState(
      topMovies: topMovies ?? this.topMovies,
      languages: languages ?? this.languages,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
