// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  /// Connect the generated [_$GenreFromJson] function to the `fromJson`
  /// factory.
  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);

  /// Connect the generated [_$GenreFromJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GenreToJson(this);
}
