import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_assignment/model/news_model.dart';

class NewsController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function to get the current user
  User? get currentUser => _auth.currentUser;
  Future<List<NewsItem>> fetchNews() async {
    final response = await http.get(
      Uri.parse(
          'https://api.currentsapi.services/v1/latest-news?apiKey=0205oHeHokVi10-gYRy-068_nDuL5syoF0SP_bhqQozSZnAj'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = NewsModel.fromJson(jsonResponse);

      return newsResponse.news;
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<List<NewsItem>> fetchCategoryNews(String category) async {
    final response = await http.get(
      Uri.parse(
          'https://api.currentsapi.services/v1/latest-news?apiKey=0205oHeHokVi10-gYRy-068_nDuL5syoF0SP_bhqQozSZnAj&category=$category'),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final newsResponse = NewsModel.fromJson(jsonResponse);

      return newsResponse.news;
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  Future<List<NewsItem>> getBookmarkedArticles() async {
    final user = _auth.currentUser;
    if (user == null) {
      return [];
    }

    final bookmarksSnapshot =
        await FirebaseFirestore.instance.collection('bookmarks').doc().get();

    final List<NewsItem> bookmarkedArticles = [];
    final data1 = bookmarksSnapshot.data();
    final art = NewsItem.fromJson(data1!);
    bookmarkedArticles.add(art);

    return bookmarkedArticles;
  }
  
}
