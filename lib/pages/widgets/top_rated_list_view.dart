import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/models/models.dart';
import 'package:infinit_frontend_assessment/pages/pages.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TopRatedListView extends StatefulWidget {
  const TopRatedListView({super.key});

  @override
  State<TopRatedListView> createState() => _TopRatedListViewState();
}

class _TopRatedListViewState extends State<TopRatedListView> with AutomaticKeepAliveClientMixin {
  final PagingController<int, Movie> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) => context.read<MoviesCubit>().onFetchTopMovies(page: pageKey));
  }

  @override
  void dispose() {
    super.dispose();
    _pagingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Required when using AutomaticKeepAliveClientMixin
    return BlocConsumer<MoviesCubit, MoviesState>(
      listener: (context, state) {
        if (state.status == MoviesStatus.loaded) {
          final isLastPage = state.hasReachedMax;
          if (isLastPage) {
            _pagingController.appendLastPage(state.pagedTopMovies);
          } else {
            final nextPageKey = (_pagingController.nextPageKey ?? _pagingController.firstPageKey) + 1;
            _pagingController.appendPage(state.pagedTopMovies, nextPageKey);
          }
        } else if (state.status == MoviesStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message.toString()),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) => PagedListView.separated(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<Movie>(
          itemBuilder: (context, topMovie, index) => ListTile(
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
          ),
          firstPageErrorIndicatorBuilder: (context) => Text('Error: ${_pagingController.error}'),
          // newPageErrorIndicatorBuilder: (context) => Text('Error: ${_pagingController.error}'),
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 8),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
