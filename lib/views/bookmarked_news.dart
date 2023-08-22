import 'package:flutter/material.dart';
import 'package:news_app_assignment/controller/news_controller.dart';
import 'package:news_app_assignment/model/news_model.dart';

class BookmarkedArticlesScreen extends StatefulWidget {
  const BookmarkedArticlesScreen({super.key});

  @override
  _BookmarkedArticlesScreenState createState() =>
      _BookmarkedArticlesScreenState();
}

class _BookmarkedArticlesScreenState extends State<BookmarkedArticlesScreen> {
   List<NewsItem>bookmarkedArticles=[];

  @override
  void initState() {
    super.initState();
    fetchBookmarkedArticles();
  }

  Future<void> fetchBookmarkedArticles() async {
    bookmarkedArticles = await NewsController().getBookmarkedArticles();
    setState(() {}); // Trigger a UI update
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookmarked Articles'),
      ),
      body: ListView.builder(
        itemCount: bookmarkedArticles.length,
        itemBuilder: (context, index) {
          final article = bookmarkedArticles[index];
          return ListTile(
            title: Text(article.title),
            subtitle: Text(article.description),
          );
        },
      ),
    );
  }
}
