import 'package:flutter/material.dart';
import 'package:charts_flutter_new/flutter.dart' as charts;
import 'package:project/classes/trending.dart';
import 'package:project/classes/movie.dart';

class ChartPage extends StatefulWidget {
  final List<Trending<Movie>> trending;

  const ChartPage({Key? key, required this.trending}) : super(key: key);

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending Stats"),
      ),
      body: charts.BarChart(
        [
          charts.Series(
            id: "Trending Ratings",
            domainFn: (rf, _) => rf.rating,
            measureFn: (rf, _) => rf.frequency,
            data: _calculateFrequencies(),
          ),
        ],
      )
    );
  }

  List<RatingFrequency> _calculateFrequencies() {
    Map<String, int> frequencies = {
      "0": 0,
      "1": 0,
      "2": 0,
      "3": 0,
      "4": 0,
      "5": 0,
    };

    for (Trending<Movie> movie in widget.trending) {
      String rating = movie.rating.floor().toString();
      int oldFreq = frequencies[rating]!;
      frequencies[rating] = oldFreq + 1;
    }

    return ["0", "1", "2", "3", "4", "5"].map((r) => RatingFrequency(rating: r, frequency: frequencies[r]!)).toList();
  }
}

class RatingFrequency {
  final String rating;
  final int frequency;

  const RatingFrequency({required this.rating, required this.frequency});
}