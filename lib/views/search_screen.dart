// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String searchKeywords = '';
  List<dynamic> searchResults = [];

  void onSearchSubmit() async {
    await searchArticles(searchKeywords);
    setState(() {});
  }

  Future<void> searchArticles(String keywords) async {
    final apiKey = '0205oHeHokVi10-gYRy-068_nDuL5syoF0SP_bhqQozSZnAj';
    final apiUrl =
        'https://api.currentsapi.services/v1/search?keywords=$keywords&apiKey=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        searchResults = data['news'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              searchKeywords = value;
            });
          },
          onSubmitted: (_) => onSearchSubmit(),
          decoration: const InputDecoration(
            hintText: 'Enter keywords...',
          ),
        ),
        actions: [
          IconButton(
            onPressed: onSearchSubmit,
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final article = searchResults[index];
          // Build and return a widget to display each search result
          return ListTile(
            leading: Image.network(article['image']),
            title: Text(
              article['title'],
              maxLines: 1,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              article['description'],
              maxLines: 3,
            ),
            // Other relevant UI elements
          );
        },
      ),
    );
  }
}
