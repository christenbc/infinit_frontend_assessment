import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';

class TopRatedListView extends StatelessWidget {
  const TopRatedListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) => ListView.separated(
        itemCount: state.topMovies.length,
        itemBuilder: (context, index) {
          final topMovie = state.topMovies[index];
          return ListTile(
            leading: AspectRatio(
              aspectRatio: 1,
              child: Image.network(
                topMovie.posterImageThumb,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(topMovie.title),
            trailing: Text('⭐ ${topMovie.vote_average.toString()}'),
          );
        },
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }
}
