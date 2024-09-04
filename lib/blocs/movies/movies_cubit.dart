import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinit_frontend_assessment/api/tmdb_api.dart';
import 'package:infinit_frontend_assessment/models/models.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(const MoviesState());

  Future<void> onStartup() async {
    onLoadLanguages();
    onLoadGenres();
  }

  Future<void> onLoadLanguages() async {
    emit(state.copyWith(status: MoviesStatus.loadingLanguages));
    try {
      final languages = await TMDBAPI.fetchLanguages();
      emit(state.copyWith(
        languages: languages,
        status: MoviesStatus.languagesLoaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MoviesStatus.failure,
        failure: Failure(message: 'Languages data could not be fetched. Reason: $e'),
      ));
    }
  }

  Future<void> onLoadGenres() async {
    emit(state.copyWith(status: MoviesStatus.loadingGenres));
    try {
      final genres = await TMDBAPI.fetchGenres();
      emit(state.copyWith(
        genres: genres,
        status: MoviesStatus.genresLoaded,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MoviesStatus.failure,
        failure: Failure(message: 'Genres data could not be fetched. Reason: $e'),
      ));
    }
  }

  Future<void> onFetchTopMovies({required int page}) async {
    emit(state.copyWith(status: MoviesStatus.loading));

    try {
      final topRatedResponse = await TMDBAPI.fetchTopRatedMovies(page: page);
      final isLastPage = topRatedResponse.results.length == topRatedResponse.total_results;
      final updatedTopMovies = List<Movie>.from(state.topMovies)..addAll(topRatedResponse.results);
      emit(state.copyWith(
        status: MoviesStatus.loaded,
        topMovies: updatedTopMovies,
        pagedTopMovies: topRatedResponse.results,
        hasReachedMax: isLastPage,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: MoviesStatus.failure,
        failure: Failure(message: 'Movies could not be fetched. Reason: $e'),
      ));
    }
  }
}
