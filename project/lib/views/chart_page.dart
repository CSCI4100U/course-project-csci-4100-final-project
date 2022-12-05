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
  var avgRating = 0;
  @override
  void initState(){
    _calculateFrequencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending Stats"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 500,
            child: charts.BarChart(
              [
                charts.Series(
                  id: "Trending Ratings",
                  domainFn: (rf, _) => rf.rating,
                  measureFn: (rf, _) => rf.frequency,
                  data: _calculateFrequencies(),
                ),
              ],
              animate: true,
              behaviors: [
                charts.ChartTitle('Ratings of Trending Movies',
                    behaviorPosition: charts.BehaviorPosition.top,
                    titleOutsideJustification: charts.OutsideJustification.start,
                    innerPadding: 30),
                charts.ChartTitle('Rating',
                    behaviorPosition: charts.BehaviorPosition.bottom,
                    titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
                charts.ChartTitle('Number of Movies',
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification:
                    charts.OutsideJustification.middleDrawArea),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: Text(
              "Average Rating of the Trending Movies: $avgRating",
              style: const TextStyle(
                fontFamily: "Lato",
                fontSize: 20,
              ),
            ),
          )
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
    var count =0;
    for (Trending<Movie> movie in widget.trending) {
      String rating = movie.rating.floor().toString();
      int oldFreq = frequencies[rating]!;
      frequencies[rating] = oldFreq + 1;
      count = count + 1;
      avgRating = avgRating + movie.rating.toInt();
    }
    avgRating = avgRating~/count;
    return ["0", "1", "2", "3", "4", "5"].map((r) => RatingFrequency(rating: r, frequency: frequencies[r]!)).toList();
  }
}

class RatingFrequency {
  final String rating;
  final int frequency;

  const RatingFrequency({required this.rating, required this.frequency});
}