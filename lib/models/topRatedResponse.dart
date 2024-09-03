// ignore_for_file: non_constant_identifier_names
import 'package:infinit_frontend_assessment/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'topRatedResponse.g.dart';

@JsonSerializable()
class TopRatedResponse {
  final int page;
  final List<Movie> results;
  final int total_pages;
  final int total_results;

  TopRatedResponse({
    required this.page,
    required this.results,
    required this.total_pages,
    required this.total_results,
  });

  /// Connect the generated [_$TopRatedResponseFromJson] function to the `fromJson`
  /// factory.
  factory TopRatedResponse.fromJson(Map<String, dynamic> json) => _$TopRatedResponseFromJson(json);

  /// Connect the generated [_$TopRatedResponseFromJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$TopRatedResponseToJson(this);
}
