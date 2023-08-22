// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class NewsModel {
  String status;
  List<NewsItem> news;

  NewsModel({required this.status, required this.news});

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      status: json['status'],
      news: (json['news'] as List<dynamic>)
          .map((item) => NewsItem.fromJson(item))
          .toList(),
    );
  }
}

class NewsItem {
  String id;
  String title;
  String description;
  String url;
  String author;
  String image;
  String language;
  List<String> category;
  String published;
  bool isBookMarked;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.url,
    required this.author,
    required this.image,
    required this.language,
    required this.category,
    required this.published,
    this.isBookMarked=false,
  });

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      url: json['url'],
      author: json['author'],
      image: json['image'],
      language: json['language'],
      category: List<String>.from(json['category']),
      published: json['published'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'url': url,
      'author': author,
      'image': image,
      'language': language,
      'category': category,
      'published': published,
      'isBookmared': isBookMarked,
    };
  }

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      url: map['url'] as String,
      author: map['author'] as String,
      image: map['image'] as String,
      language: map['language'] as String,
      category: List<String>.from((map['category'] as List<String>)),
      published: map['published'] as String,
      isBookMarked: map['isBookmared'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  

  NewsItem copyWith({
    String? id,
    String? title,
    String? description,
    String? url,
    String? author,
    String? image,
    String? language,
    List<String>? category,
    String? published,
    bool? isBookMarked,
  }) {
    return NewsItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      author: author ?? this.author,
      image: image ?? this.image,
      language: language ?? this.language,
      category: category ?? this.category,
      published: published ?? this.published,
      isBookMarked: isBookMarked ?? this.isBookMarked,
    );
  }
}
