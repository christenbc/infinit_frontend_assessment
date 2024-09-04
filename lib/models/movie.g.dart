// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      adult: json['adult'] as bool,
      backdrop_path: json['backdrop_path'] as String,
      poster_path: json['poster_path'] as String,
      original_language: json['original_language'] as String,
      overview: json['overview'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      release_date: json['release_date'] as String,
      vote_average: (json['vote_average'] as num).toDouble(),
      vote_count: (json['vote_count'] as num).toInt(),
      genre_ids: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'adult': instance.adult,
      'backdrop_path': instance.backdrop_path,
      'poster_path': instance.poster_path,
      'original_language': instance.original_language,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'release_date': instance.release_date,
      'vote_average': instance.vote_average,
      'vote_count': instance.vote_count,
      'genre_ids': instance.genre_ids,
    };
