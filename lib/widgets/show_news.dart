import 'package:flutter/material.dart';
import 'package:news_app/widgets/custom_widget.dart';
import 'package:news_app/widgets/list_widget.dart';
import 'package:news_app/model/news.dart';

class ShowNews extends StatelessWidget {
  final News? news;
  final bool isLoading;
  const ShowNews({Key? key, required this.news, required this.isLoading})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
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
    } else {
      if (news == null) {
        return const Center(
            child: Text(
          "Something went wrong\nPlease Try Again Later",
          style: TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
        ));
      } else {
        final article = news!.articles;
        return ListView.builder(
          itemBuilder: (context, index) {
            return ListWidget(
              article: article,
              index: index,
            );
          },
          itemCount: article!.length,
        );
      }
    }
  }
}
