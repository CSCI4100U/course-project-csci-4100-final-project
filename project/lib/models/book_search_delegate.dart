import 'package:flutter/material.dart';
import 'package:project/classes/book.dart';
import 'package:project/models/fetch_data.dart';

class BookSearchDelegate extends SearchDelegate<Book?> {
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
    return Container();
    /*
    return FutureBuilder<List<Book>>(
      future: Fetch.fetchBooksFromSearchQuery(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: BookTile(movie: snapshot.data![index]),
                onTap: () => close(context, snapshot.data![index]),
              );
            }
        );
      }
    );*/
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }
}