// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'movies_cubit.dart';

enum MoviesStatus {
  initial,
  loading,
  loadingLanguages,
  loadingGenres,
  loaded,
  languagesLoaded,
  genresLoaded,
  failure,
}

class MoviesState extends Equatable {
  final List<Movie> topMovies;
  final List<Language> languages;
  final List<Genre> genres;
  final bool hasReachedMax;
  final MoviesStatus status;
  final Failure failure;

  const MoviesState({
    this.topMovies = const [],
    this.languages = const [],
    this.genres = const [],
    this.hasReachedMax = false,
    this.status = MoviesStatus.initial,
    this.failure = const Failure(),
  });

  Map<int, int> get getGenresCount {
    final genreCount = <int, int>{};

    for (final movie in topMovies) {
      for (final genreId in movie.genre_ids) {
        if (genreCount.containsKey(genreId)) {
          genreCount[genreId] = genreCount[genreId]! + 1;
        } else {
          genreCount[genreId] = 1;
        }
      }
    }

    return genreCount;
  }

  List<MapEntry<int, int>> get sortedGenres =>
      getGenresCount.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  List<MapEntry<int, int>> get top3Genres => sortedGenres.take(3).toList();

  @override
  List<Object> get props => [
        topMovies,
        languages,
        genres,
        hasReachedMax,
        status,
        failure,
      ];

  MoviesState copyWith({
    List<Movie>? topMovies,
    List<Language>? languages,
    List<Genre>? genres,
    bool? hasReachedMax,
    MoviesStatus? status,
    Failure? failure,
  }) {
    return MoviesState(
      topMovies: topMovies ?? this.topMovies,
      languages: languages ?? this.languages,
      genres: genres ?? this.genres,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
