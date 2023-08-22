import 'package:flutter/material.dart';
import 'package:news_app_assignment/utils/global_varialbles.dart';
import 'package:news_app_assignment/views/category_feed_screen.dart';
import 'package:news_app_assignment/views/home_page.dart';
import 'package:news_app_assignment/views/search_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.settings),
        title: const Text(
          'Discover',
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const HomePage(),
              ),
            ),
            child: const Row(
              children: [
                Text('My Feed'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage())),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                    prefixIcon: GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SearchScreen())),
                      child: const Icon(
                        Icons.search,
                        color: Colors.grey,
                      ),
                    ),
                    hintText: 'Search for News',
                    hintStyle: const TextStyle(color: Colors.grey),
                    fillColor: const Color.fromARGB(62, 158, 158, 158),
                    filled: true,
                    enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    contentPadding: const EdgeInsets.all(0)),
              ),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 250,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: GlobalVariables.categoryImages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CategoryFeedScreen(
                                category: GlobalVariables.categoryImages[index]
                                    ['category']!))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Image.asset(
                              GlobalVariables.categoryImages[index]['image']!),
                          Text(
                            GlobalVariables.categoryImages[index]['category']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 19),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
