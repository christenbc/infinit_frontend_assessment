import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/models/models.dart';

String getGenreFromId(MoviesState state, int genreId) =>
    state.genres.where((genre) => genre.id == genreId).firstOrNull?.name ?? genreId.toString();

String getLanguageFromLanguageId(MoviesState state, String languageId) =>
    state.languages.where((language) => languageId == language.iso_639_1).firstOrNull?.english_name ?? languageId;
