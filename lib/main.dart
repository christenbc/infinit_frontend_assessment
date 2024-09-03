import 'package:flutter/material.dart';
import 'package:infinit_frontend_assessment/api/tmdb_api.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinit_frontend_assessment/pages/pages.dart';

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
        child: const HomePage(title: 'Top Rated Movies'),
      ),
    );
  }
}
