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
  final List<Movie> pagedTopMovies;
  final List<Language> languages;
  final List<Genre> genres;
  final bool hasReachedMax;
  final MoviesStatus status;
  final Failure failure;

  const MoviesState({
    this.topMovies = const [],
    this.pagedTopMovies = const [],
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

  Map<int, int> get countMoviesPerYear {
    final Map<int, int> moviesPerYear = {};

    for (final movie in topMovies) {
      final year = DateTime.parse(movie.release_date).year;
      if (moviesPerYear.containsKey(year)) {
        moviesPerYear[year] = moviesPerYear[year]! + 1;
      } else {
        moviesPerYear[year] = 1;
      }
    }

    return moviesPerYear;
  }

  List<MapEntry<int, int>> get sortedCountMoviesPerTrend =>
      countMoviesPerYear.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

  List<MapEntry<int, int>> get top5BestYears => sortedCountMoviesPerTrend.take(5).toList();

  @override
  List<Object> get props => [
        topMovies,
        pagedTopMovies,
        languages,
        genres,
        hasReachedMax,
        status,
        failure,
      ];

  MoviesState copyWith({
    List<Movie>? topMovies,
    List<Movie>? pagedTopMovies,
    List<Language>? languages,
    List<Genre>? genres,
    bool? hasReachedMax,
    MoviesStatus? status,
    Failure? failure,
  }) {
    return MoviesState(
      topMovies: topMovies ?? this.topMovies,
      pagedTopMovies: pagedTopMovies ?? this.pagedTopMovies,
      languages: languages ?? this.languages,
      genres: genres ?? this.genres,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      status: status ?? this.status,
      failure: failure ?? this.failure,
    );
  }
}
