import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/models/movie.dart';

const pagePadding = 24.0;

class DetailedPage extends StatelessWidget {
  final int movieIndex;

  const DetailedPage({super.key, required this.movieIndex});

  @override
  Widget build(BuildContext context) => BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) {
          final movie = state.topMovies[movieIndex];
          return Scaffold(
            appBar: AppBar(
              title: Text(movie.title),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(movie.backdropImageThumb),
                  Padding(
                    padding: const EdgeInsets.all(pagePadding),
                    child: Wrap(
                      spacing: pagePadding,
                      children: movie.genre_ids
                          .map((genreId) => Chip(
                                label: Text(getGenreFromId(state, genreId)),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: Text(movie.overview),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Release date: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: movie.release_date,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Vote average: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: movie.vote_average.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const TextSpan(
                            text: ' based on ',
                          ),
                          TextSpan(
                            text: movie.vote_count.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                          const TextSpan(
                            text: ' votes',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Popularity: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: movie.popularity.toString(),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: RichText(
                      textAlign: TextAlign.start,
                      text: TextSpan(
                        text: 'Original language: ',
                        style: const TextStyle(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                            text: getLanguageFromLanguageCode(state, movie),
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );

  String getGenreFromId(MoviesState state, int genreId) =>
      state.genres.where((genre) => genre.id == genreId).firstOrNull?.name ?? genreId.toString();

  String getLanguageFromLanguageCode(MoviesState state, Movie movie) =>
      state.languages.where((language) => movie.original_language == language.iso_639_1).firstOrNull?.english_name ??
      movie.original_language;

  EdgeInsets getInnerElementPadding() => const EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding);
}
