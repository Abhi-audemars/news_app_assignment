import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app_assignment/model/news_model.dart';

class BookmarkProvider extends ChangeNotifier {
  CollectionReference _bookmarksCollection =
      FirebaseFirestore.instance.collection('bookmarks');

  List<NewsItem> _bookmarkedArticles = [];

  List<NewsItem> get bookmarkedArticles => _bookmarkedArticles;

  Future<void> addBookmark(NewsItem newsArticle) async {
    await _bookmarksCollection.add(newsArticle.toMap());
    _bookmarkedArticles.add(newsArticle.copyWith(isBookMarked: true));
    notifyListeners();
  }

  Future<void> removeBookmark(NewsItem newsArticle) async {
    await _bookmarksCollection
        .where('title', isEqualTo: newsArticle.title)
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        doc.reference.delete();
      });
    });
    _bookmarkedArticles.remove(newsArticle);
    notifyListeners();
  }

  void toggleBookmark(NewsItem article) {
    article.isBookMarked = !article.isBookMarked;
    notifyListeners();
  }

  Future<void> fetchBookmarks() async {
    var snapshot = await _bookmarksCollection.get();
    _bookmarkedArticles = snapshot.docs
        .map((doc) => NewsItem.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    notifyListeners();
  }
}
