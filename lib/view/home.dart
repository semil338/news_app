import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:news_app/custom_widget.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/platform_alert.dart';
import 'package:news_app/services/api_service.dart';
import 'package:news_app/view/news_detail.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<News?>? news;
  @override
  void initState() {
    super.initState();
    // _getData(text);
  }

  final List<String> _list = [
    "General",
    "Business",
    "Entertainment",
    "Health",
    "Science",
    "Sports",
    "Technology",
  ];
  @override
  Widget build(BuildContext context) {
    final apiService = Provider.of<ApiService>(context, listen: false);
    return DefaultTabController(
      length: _list.length,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.menu, color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ))
          ],
          title: Text(
            "Daily News",
            style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontFamily: GoogleFonts.italianno().fontFamily),
          ),
          backgroundColor: const Color(0xFFFAFAFA),
          elevation: 10,
          centerTitle: true,
          bottom: TabBar(
            labelColor: Colors.black,
            indicatorColor: Colors.black,
            isScrollable: true,
            tabs: [
              for (var item in _list) Tab(text: item),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            for (var item in _list)
              RefreshIndicator(
                  onRefresh: () => apiService.getNewsData(item),
                  child: showNews(apiService, item))
          ],
        ),
      ),
    );
  }

  Future<void> _getData(String text, ApiService apiService) async {
    try {} on SocketException catch (e) {
      PlatformAlertDialog(
        title: "Error",
        content: e.message,
        defaultActionText: "Ok",
      );
    } catch (_) {
      PlatformAlertDialog(
        title: "Unknown Error",
        content: "Please contact support or try again later.",
        defaultActionText: "OK",
      );
    }
  }

  Widget showNews(ApiService apiService, String text) {
    return FutureBuilder<News?>(
      future: news,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return const Center(
                child: Text(
              "Something went wrong\nPlease Try Again Later",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ));
          } else {
            final article = snapshot.data!.articles;
            return ListView.builder(
              itemBuilder: (context, index) {
                String? author = article![index].author ?? "Unknown";
                String img = article[index].urlToImage.toString();
                String title = article[index].title.toString();
                String description = article[index].url.toString();

                DateTime now =
                    DateTime.parse(article[index].publishedAt.toString())
                        .toLocal();
                String date = DateFormat.yMMMd().format(now);
                String time = DateFormat.jm().format(now);
                String date1 = date + " " + time;

                return listWidget(
                  author: author,
                  date: date1,
                  img: img,
                  title: title,
                  context: context,
                  newsDescription: description,
                );
              },
              itemCount: article!.length,
            );
          }
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              leading: const CustomWidget.circular(height: 80, width: 80),
              title: Align(
                alignment: Alignment.centerLeft,
                child: CustomWidget.rectangular(
                  height: 16,
                  width: MediaQuery.of(context).size.width * 0.3,
                ),
              ),
              subtitle: const CustomWidget.rectangular(height: 14),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.none) {
          return const Text("None");
        } else {
          return const Text("Error");
        }
      },
    );
  }
}

Widget listWidget(
    {required String img,
    required String title,
    required String date,
    required String author,
    required BuildContext context,
    required String newsDescription}) {
  return InkWell(
    onTap: () => Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => NewsDetail(
        description: newsDescription,
      ),
    )),
    child: Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 20),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(img),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 5),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    const Icon(Icons.date_range),
                    Container(
                        margin: const EdgeInsets.only(left: 8),
                        child:
                            Text(date, style: const TextStyle(fontSize: 13))),
                  ],
                ),
              ],
            )),
          ],
        ),
      ),
    ),
  );
}
