// ignore_for_file: non_constant_identifier_names
import 'package:json_annotation/json_annotation.dart';

part 'language.g.dart';

@JsonSerializable()
class Language {
  final String iso_639_1;
  final String english_name;
  final String name;

  Language({
    required this.iso_639_1,
    required this.english_name,
    required this.name,
  });

  /// Connect the generated [_$LanguageFromJson] function to the `fromJson`
  /// factory.
  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

  /// Connect the generated [_$LanguageFromJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$LanguageToJson(this);
}
