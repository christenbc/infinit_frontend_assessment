import 'package:flutter/material.dart';
import 'package:infinit_frontend_assessment/models/models.dart';

const pagePadding = 24.0;

class DetailedPage extends StatelessWidget {
  final Movie movie;

  const DetailedPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) => Scaffold(
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
                        text: movie.original_language,
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

  EdgeInsets getInnerElementPadding() => const EdgeInsets.fromLTRB(pagePadding, 0, pagePadding, pagePadding);
}
