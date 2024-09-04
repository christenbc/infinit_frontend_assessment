import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/utils.dart';

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
              title: Text(movie.title!),
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
                      children: movie.genre_ids!
                          .map((genreId) => Chip(
                                label: Text(getGenreFromId(state, genreId)),
                              ))
                          .toList(),
                    ),
                  ),
                  Padding(
                    padding: getInnerElementPadding(),
                    child: Text(movie.overview!),
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
                            text: movie.vote_average!.toStringAsFixed(2),
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
                        text: 'Popularity factor: ',
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
                            text: getLanguageFromLanguageId(state, movie.original_language!),
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

  EdgeInsets getInnerElementPadding() => const EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding);
}
