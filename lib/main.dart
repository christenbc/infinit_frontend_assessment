import 'package:flutter/material.dart';
import 'package:infinit_frontend_assessment/api/tmdb_api.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await TMDBAPI.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Infinit Frontend Assessment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BlocProvider<MoviesCubit>(
        create: (context) => MoviesCubit(),
        child: const MyHomePage(title: 'Top Rated Movies'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    context.read<MoviesCubit>().onFetchTopMovies(pageKey: 1);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'List'),
              Tab(text: 'Summary'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            ListViewPage(), // Your paginated list
            SummaryPage(), // Your summary view
          ],
        ),
      ),
    );
  }
}

class ListViewPage extends StatelessWidget {
  const ListViewPage({super.key});

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

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
