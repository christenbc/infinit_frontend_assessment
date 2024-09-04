import 'package:flutter_test/flutter_test.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/models/models.dart';

void main() {
  group('MoviesState', () {
    test('initial state should have correct default values', () {
      const state = MoviesState();

      expect(state.topMovies, []);
      expect(state.pagedTopMovies, []);
      expect(state.languages, []);
      expect(state.genres, []);
      expect(state.hasReachedMax, false);
      expect(state.status, MoviesStatus.initial);
      expect(state.failure, const Failure());
    });

    test('copyWith should correctly override specified values', () {
      const originalState = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Test Movie', genre_ids: [1], release_date: '2020-01-01', original_language: 'en')
        ],
        status: MoviesStatus.loading,
        hasReachedMax: false,
      );

      final copiedState = originalState.copyWith(
        status: MoviesStatus.loaded,
        hasReachedMax: true,
      );

      expect(copiedState.topMovies, originalState.topMovies);
      expect(copiedState.status, MoviesStatus.loaded);
      expect(copiedState.hasReachedMax, true);
      expect(copiedState.languages, originalState.languages);
    });

    test('getGenresCount should correctly count genres', () {
      const state = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Movie 1', genre_ids: [1, 2], release_date: '2020-01-01', original_language: 'en'),
          Movie(id: 2, title: 'Movie 2', genre_ids: [1, 3], release_date: '2021-01-01', original_language: 'en'),
        ],
      );

      expect(state.getGenresCount, {1: 2, 2: 1, 3: 1});
    });

    test('top5Genres should return top 5 genres', () {
      const state = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Movie 1', genre_ids: [1, 2], release_date: '2020-01-01', original_language: 'en'),
          Movie(id: 2, title: 'Movie 2', genre_ids: [1, 3], release_date: '2021-01-01', original_language: 'en'),
          Movie(id: 3, title: 'Movie 3', genre_ids: [2, 3], release_date: '2021-01-01', original_language: 'en'),
          Movie(id: 4, title: 'Movie 4', genre_ids: [3], release_date: '2021-01-01', original_language: 'en'),
        ],
      );

      final top5Genres = state.top5Genres;

      // Check if the length is as expected
      expect(top5Genres.length, 3);

      // Compare each MapEntry's key and value
      expect(top5Genres[0].key, 3);
      expect(top5Genres[0].value, 3);

      expect(top5Genres[1].key, 1);
      expect(top5Genres[1].value, 2);

      expect(top5Genres[2].key, 2);
      expect(top5Genres[2].value, 2);
    });

    test('getInternationalLanguagesCount should exclude English and count other languages', () {
      const state = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Movie 1', genre_ids: [1], release_date: '2020-01-01', original_language: 'en'),
          Movie(id: 2, title: 'Movie 2', genre_ids: [1], release_date: '2021-01-01', original_language: 'es'),
          Movie(id: 3, title: 'Movie 3', genre_ids: [1], release_date: '2021-01-01', original_language: 'fr'),
          Movie(id: 4, title: 'Movie 4', genre_ids: [1], release_date: '2021-01-01', original_language: 'es'),
        ],
      );

      expect(state.getInternationalLanguagesCount, {'es': 2, 'fr': 1});
    });

    test('sortedInternationalLanguagesCount should return languages sorted by count', () {
      const state = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Movie 1', genre_ids: [1], release_date: '2020-01-01', original_language: 'es'),
          Movie(id: 2, title: 'Movie 2', genre_ids: [1], release_date: '2021-01-01', original_language: 'fr'),
          Movie(id: 3, title: 'Movie 3', genre_ids: [1], release_date: '2021-01-01', original_language: 'es'),
        ],
      );

      final sortedLanguages = state.sortedInternationalLanguagesCount;

      expect(sortedLanguages.length, 2);

      // Compare the first entry's key and value
      expect(sortedLanguages[0].key, 'es');
      expect(sortedLanguages[0].value, 2);

      // Compare the second entry's key and value
      expect(sortedLanguages[1].key, 'fr');
      expect(sortedLanguages[1].value, 1);
    });

    test('equality should work for identical states', () {
      const state1 = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Test Movie', genre_ids: [1], release_date: '2020-01-01', original_language: 'en')
        ],
        status: MoviesStatus.loading,
      );

      const state2 = MoviesState(
        topMovies: [
          Movie(id: 1, title: 'Test Movie', genre_ids: [1], release_date: '2020-01-01', original_language: 'en')
        ],
        status: MoviesStatus.loading,
      );

      expect(state1, state2);
    });

    test('failure handling should work correctly', () {
      const failure = Failure(message: 'An error occurred');
      const state = MoviesState(failure: failure);

      expect(state.failure.message, 'An error occurred');
    });
  });
}
