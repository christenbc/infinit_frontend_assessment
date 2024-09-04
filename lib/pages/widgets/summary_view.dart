import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/pages/widgets/widgets.dart';
import 'package:infinit_frontend_assessment/utils.dart';

const pagePadding = 16.0;

class SummaryView extends StatefulWidget {
  const SummaryView({super.key});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

class _SummaryViewState extends State<SummaryView> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<MoviesCubit, MoviesState>(
      builder: (context, state) => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(pagePadding),
              child: Text(
                'Top 3 genres:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...state.top3Genres.mapIndexed((index, genre) => ListTile(
                  title: Text('${index + 1}. ${getGenreFromId(state, genre.key)}'),
                  trailing: Text('${genre.value} of ${state.topMovies.length}'),
                )),
            Padding(
              padding: const EdgeInsets.all(pagePadding),
              child: Text(
                'Best 5 years:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            ...state.top5BestYears.mapIndexed((index, countMoviesPerYear) => ListTile(
                  title:
                      Text('${index + 1}. ${countMoviesPerYear.key} had ${countMoviesPerYear.value} top rated movies'),
                  // trailing: Text('${genre.value} of ${state.topMovies.length}'),
                )),
            Padding(
              padding: const EdgeInsets.all(pagePadding),
              child: Text(
                'Vote count vs Vote Average based on genre:',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(
              height: 800,
              child: Padding(
                padding: const EdgeInsets.all(pagePadding),
                child: VoteScatterPlot(
                  moviesState: state,
                  movies: state.topMovies,
                  genres: state.genres,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
