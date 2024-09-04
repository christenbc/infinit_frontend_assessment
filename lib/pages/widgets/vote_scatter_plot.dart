import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:infinit_frontend_assessment/blocs/blocs.dart';
import 'package:infinit_frontend_assessment/models/models.dart';
import 'package:infinit_frontend_assessment/utils.dart';

class VoteScatterPlot extends StatelessWidget {
  final List<Movie> movies;
  final List<Genre> genres;
  final MoviesState moviesState;

  const VoteScatterPlot({
    super.key,
    required this.movies,
    required this.genres,
    required this.moviesState,
  });

  @override
  Widget build(BuildContext context) {
    // Organize data for scatter plot
    final List<ScatterSpot> spots = [];
    final Map<int, Color> genreColors = _generateColorsForGenres(genres.map((e) => e.id).toList());

    for (var movie in movies) {
      final spot = ScatterSpot(
        movie.vote_count!.toDouble(),
        movie.vote_average!,
        dotPainter: FlDotCirclePainter(
          color: genreColors[movie.genre_ids!.first] ?? Colors.grey,
        ),
      );
      spots.add(spot);
    }

    return Column(
      children: [
        Expanded(
          child: ScatterChart(
            ScatterChartData(
              scatterTouchData: ScatterTouchData(
                touchTooltipData: ScatterTouchTooltipData(
                  getTooltipItems: (ScatterSpot scatterSpot) => ScatterTooltipItem(
                    'x: ${scatterSpot.x}\ny: ${scatterSpot.y}',
                    textStyle: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
              scatterSpots: spots,
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: const Color(0xff37434d),
                  width: 1,
                ),
              ),
              gridData: const FlGridData(show: false),
              titlesData: const FlTitlesData(
                bottomTitles: AxisTitles(
                  axisNameWidget: Text('Vote Count'),
                  sideTitles: SideTitles(
                    reservedSize: 26,
                    showTitles: true,
                    maxIncluded: false,
                  ),
                ),
                leftTitles: AxisTitles(
                  axisNameWidget: Text('Vote Average'),
                  sideTitles: SideTitles(
                    reservedSize: 46,
                    showTitles: true,
                    maxIncluded: false,
                  ),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
            ),
          ),
        ),
        // Legend
        Container(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Legend'),
              ...genreColors.entries.map((entry) {
                final genreId = entry.key;
                final color = entry.value;
                final genreName = getGenreFromId(moviesState, genreId);

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 20,
                        height: 20,
                        color: color,
                        margin: const EdgeInsets.only(right: 8.0),
                      ),
                      Text(genreName),
                    ],
                  ),
                );
              })
            ],
          ),
        ),
      ],
    );
  }

  Map<int, Color> _generateColorsForGenres(List<int> genreIds) {
    final Set<int> uniqueGenres = genreIds.toSet();
    final List<Color> colors = _generateDistinctColors(uniqueGenres.length);
    final Map<int, Color> genreColors = {};

    int i = 0;
    for (int genreId in uniqueGenres) {
      genreColors[genreId] = colors[i % colors.length];
      i++;
    }

    return genreColors;
  }
}

List<Color> _generateDistinctColors(int count) {
  final List<Color> colors = [];
  for (int i = 0; i < count; i++) {
    final hue = i * 360 / count; // Spread hues evenly across the color wheel
    final color = HSLColor.fromAHSL(1.0, hue, 0.7, 0.7).toColor();
    colors.add(color);
  }
  return colors;
}
