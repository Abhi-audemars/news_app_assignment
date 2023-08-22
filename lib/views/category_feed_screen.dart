// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:news_app_assignment/controller/news_controller.dart';
import 'package:news_app_assignment/model/news_model.dart';
import 'package:news_app_assignment/views/details_view.dart';

class CategoryFeedScreen extends StatefulWidget {
  String category;
  CategoryFeedScreen({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  State<CategoryFeedScreen> createState() => _CategoryFeedScreenState();
}

class _CategoryFeedScreenState extends State<CategoryFeedScreen> {
  List<NewsItem> newsItems = [];
  int currentPage = 0;

  final NewsController newsController = NewsController();

  final PageController _pageController = PageController();

  Future<void> fetchNews() async {
    newsItems = await newsController.fetchCategoryNews(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: newsItems.length,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) {
          if (index == newsItems.length - 1) {
            fetchNews();
          }
          setState(() {
            currentPage = index;
          });
        },
        itemBuilder: (context, index) {
          final newsItem = newsItems[index];

          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FadeInImage.assetNetwork(
                      height: 350,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                      placeholder: "assets/wait.png",
                      image: newsItem.image),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            newsItem.title.length > 90
                                ? "${newsItem.title.substring(0, 90)}..."
                                : newsItem.title,
                            style: const TextStyle(
                                fontSize: 23, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Category: ${newsItem.category.first}',
                            style: const TextStyle(
                                fontSize: 12, color: Colors.black38),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            newsItem.description,
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ]),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 6),
                            child: Row(
                              children: [
                                Icon(Icons.bookmark_outline),
                                Text('Bookmark')
                              ],
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailViewScreen(
                                          newsUrl: newsItem.url)));
                            },
                            child: const Text("Read More")),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ]),
          );
        },
      ),
    );
  }
}
