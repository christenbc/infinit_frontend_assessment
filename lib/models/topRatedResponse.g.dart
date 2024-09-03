// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topRatedResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopRatedResponse _$TopRatedResponseFromJson(Map<String, dynamic> json) =>
    TopRatedResponse(
      page: (json['page'] as num).toInt(),
      results: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      total_pages: (json['total_pages'] as num).toInt(),
      total_results: (json['total_results'] as num).toInt(),
    );

Map<String, dynamic> _$TopRatedResponseToJson(TopRatedResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.results,
      'total_pages': instance.total_pages,
      'total_results': instance.total_results,
    };
