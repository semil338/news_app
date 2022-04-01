import 'dart:io';
import 'package:flutter/material.dart';
import 'package:news_app/widgets/appbar_title.dart';
import 'package:news_app/widgets/category_card.dart';
import 'package:news_app/widgets/show_alert_dialog.dart';
import 'package:news_app/model/category_list.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repositories/data_repositories.dart';
import 'package:news_app/widgets/show_news.dart';
import 'package:news_app/view/category_news_page.dart';
import 'package:news_app/view/news_search.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  News? news;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    _getData("General");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: appBar(context),
      body: RefreshIndicator(
        onRefresh: () => _getData("General"),
        child: Column(
          children: [
            categoryCard(),
            Expanded(child: ShowNews(news: news, isLoading: _isLoading))
          ],
        ),
      ),
    );
  }

  Future<void> _getData(String text) async {
    try {
      setState(() {
        _isLoading = true;
      });
      final dataRepo = Provider.of<DataRepository>(context, listen: false);
      final data = await dataRepo.getNewsData(text);
      setState(() {
        news = data;
        _isLoading = false;
      });
    } on SocketException catch (_) {
      showAlertDialog(
          context: context,
          title: "Connection Error",
          content: "Could not retrieve data.Please try again later.",
          defaultTextAction: "OK");
    } catch (_) {
      showAlertDialog(
        context: context,
        title: "Unknown Error",
        content: "Please contact support or try again later.",
        defaultTextAction: "OK",
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu),
      ),
      actions: [
        IconButton(
          onPressed: () async {
            final str = await showSearch(
              context: context,
              delegate: NewsSearch(),
            );
            if (str != null) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CategoryNewsPage(
                    category: str.toString(),
                    isSearch: true,
                  ),
                ),
              );
            }
          },
          icon: const Icon(
            Icons.search,
          ),
        )
      ],
      title: appBarTitle("Daily News", context),
    );
  }

  Widget categoryCard() {
    return Container(
      height: 70,
      margin: const EdgeInsets.all(10),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CategoryCard(
            categoryName: list[index],
            imageAssetUrl: img[index],
          );
        },
        itemCount: list.length,
      ),
    );
  }
}
