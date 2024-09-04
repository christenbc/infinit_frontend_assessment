import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/pages/pages.dart';

class TopRatedListView extends StatelessWidget {
  const TopRatedListView({super.key});

  @override
  Widget build(BuildContext context) => BlocConsumer<MoviesCubit, MoviesState>(
        listener: (context, state) {
          if (state.status == MoviesStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.failure.message.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) => ListView.separated(
          itemCount: state.topMovies.length,
          itemBuilder: (context, index) {
            final topMovie = state.topMovies[index];
            return ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailedPage(movieIndex: index)),
              ),
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
