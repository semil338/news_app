import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_app/widgets/appbar_title.dart';
import 'package:news_app/widgets/show_alert_dialog.dart';
import 'package:news_app/model/news.dart';
import 'package:news_app/repositories/data_repositories.dart';
import 'package:news_app/widgets/show_news.dart';
import 'package:provider/provider.dart';

class CategoryNewsPage extends StatefulWidget {
  final String category;
  final bool isSearch;
  const CategoryNewsPage(
      {Key? key, required this.category, required this.isSearch})
      : super(key: key);

  @override
  State<CategoryNewsPage> createState() => _CategoryNewsPageState();
}

class _CategoryNewsPageState extends State<CategoryNewsPage> {
  News? news;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _getData(widget.category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).canvasColor,
      appBar: appBar(),
      body: RefreshIndicator(
        onRefresh: () => _getData(widget.category),
        child: Column(
          children: [
            Expanded(
              child: ShowNews(news: news, isLoading: _isLoading),
            )
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
      final data = !widget.isSearch
          ? await dataRepo.getNewsData(text)
          : await dataRepo.searchNewsData(text);
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
      debugPrint("Hello");
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

  AppBar appBar() {
    return AppBar(
      title: appBarTitle(
          toBeginningOfSentenceCase(widget.category).toString(), context),
    );
  }
}
