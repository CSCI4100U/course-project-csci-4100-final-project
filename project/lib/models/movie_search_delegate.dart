import 'package:flutter/material.dart';
import 'package:project/classes/movie.dart';
import 'package:project/models/fetch_data.dart';
import 'package:project/components/movie_tile.dart';

class MovieSearchDelegate extends SearchDelegate<Movie?> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: Fetch.fetchMoviesFromSearchQuery(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              child: MovieTile(movie: snapshot.data![index]),
              onTap: () => close(context, snapshot.data![index]),
            );
          }
        );
      }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder<List<Movie>>(
        future: Fetch.fetchMoviesFromSearchQuery(query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: MovieTile(movie: snapshot.data![index]),
                  onTap: () {
                    if (query == snapshot.data![index].title) {
                      close(context, snapshot.data![index]);
                    } else {
                      query = snapshot.data![index].title;
                    }
                  }
                );
              }
          );
        }
    );
  }
}