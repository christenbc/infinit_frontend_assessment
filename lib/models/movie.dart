// ignore_for_file: non_constant_identifier_names
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie extends Equatable {
  final int id;
  final String title;
  final bool adult;
  final String backdrop_path;
  final String poster_path;
  final String original_language;
  final String overview;
  final double popularity;
  final String release_date;
  final double vote_average;
  final int vote_count;

  const Movie({
    required this.id,
    required this.title,
    required this.adult,
    required this.backdrop_path,
    required this.poster_path,
    required this.original_language,
    required this.overview,
    required this.popularity,
    required this.release_date,
    required this.vote_average,
    required this.vote_count,
  });

  // https://developer.themoviedb.org/docs/image-basics
  String get backdropImageThumb => 'https://image.tmdb.org/t/p/w500/$backdrop_path';
  String get posterImageThumb => 'https://image.tmdb.org/t/p/w500/$poster_path';

  /// Connect the generated [_$MovieFromJson] function to the `fromJson`
  /// factory.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);

  /// Connect the generated [_$MovieFromJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$MovieToJson(this);

  @override
  List<Object?> get props => [
        id,
        title,
        adult,
        backdrop_path,
        poster_path,
        original_language,
        overview,
        popularity,
        release_date,
        vote_average,
        vote_count,
      ];
}
