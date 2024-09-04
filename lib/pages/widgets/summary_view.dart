import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/utils.dart';

const pagePadding = 16.0;

class SummaryView extends StatelessWidget {
  const SummaryView({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<MoviesCubit, MoviesState>(
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(pagePadding),
                child: Text('Top 3 genres:', style: Theme.of(context).textTheme.titleLarge),
              ),
              ...state.top3Genres.mapIndexed((index, genre) => ListTile(
                    title: Text('${index + 1}. ${getGenreFromId(state, genre.key)}'),
                    trailing: Text('${genre.value} of ${state.topMovies.length}'),
                  )),
            ],
          ),
        ),
      );
}
