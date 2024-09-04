import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:infinit_frontend_assessment/api/tmdb_api.dart';
import 'package:infinit_frontend_assessment/models/models.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit() : super(const MoviesState());

  Future<void> onStartup() async {
    emit(state.copyWith(status: MoviesStatus.loading));

    try {
      final languages = await TMDBAPI.fetchLanguages();
      emit(state.copyWith(
        languages: languages,
        status: MoviesStatus.complementaryDataLoaded,
      ));
      onFetchTopMovies(pageKey: 1);
    } catch (e) {
      emit(state.copyWith(
        status: MoviesStatus.failure,
        failure: Failure(message: 'Complementary data could not be fetched. Reason: $e'),
      ));
    }
  }

  Future<void> onFetchTopMovies({required int pageKey}) async {
    emit(state.copyWith(status: MoviesStatus.loading));

    try {
      final topRatedResponse = await TMDBAPI.fetchTopRatedMovies(page: pageKey);
      final isLastPage = topRatedResponse.results.length < topRatedResponse.total_results;
      emit(state.copyWith(
        status: MoviesStatus.loaded,
        topMovies: topRatedResponse.results,
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
