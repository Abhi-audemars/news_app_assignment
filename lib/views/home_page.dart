import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app_assignment/controller/bookmark_provider.dart';
import 'package:news_app_assignment/controller/news_controller.dart';
import 'package:news_app_assignment/model/news_model.dart';
import 'package:news_app_assignment/views/details_view.dart';
import 'package:news_app_assignment/views/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<NewsItem> newsItems = [];
  int currentPage = 0;
  // final NewsItem newsItem;

  final NewsController newsController = NewsController();

  final PageController _pageController = PageController();

  Future<void> fetchNews() async {
    newsItems = await newsController.fetchNews();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final bookmarksProvider = Provider.of<BookmarkProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to MainScreen
        Navigator.popAndPushNamed(context, '/main');
        return false; // Prevent default back button behavior
      },
      child: Scaffold(
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 6),
                              child: InkWell(
                                onTap: user == null
                                    ? () => Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginView()),
                                        (route) => false)
                                    : () {
                                        if (newsItems[index].isBookMarked) {
                                          bookmarksProvider
                                              .removeBookmark(newsItems[index]);
                                          bookmarksProvider
                                              .toggleBookmark(newsItems[index]);
                                        } else {
                                          bookmarksProvider
                                              .addBookmark(newsItems[index]);
                                          bookmarksProvider
                                              .toggleBookmark(newsItems[index]);
                                        }
                                      },
                                child: Row(
                                  children: [
                                    Icon(
                                      newsItems[index].isBookMarked
                                          ? Icons.bookmark
                                          : Icons.bookmark_border,
                                    ),
                                    Text('Bookmark')
                                  ],
                                ),
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
      ),
    );
  }
}
